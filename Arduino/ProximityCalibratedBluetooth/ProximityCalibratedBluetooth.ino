/*
  mpuAccelerometerDemo
  Based on the MPU6050_DMP6 "teapot demo" code
*/


/* ============================================
I2Cdev device library code is placed under the MIT license
Copyright (c) 2012 Jeff Rowberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
===============================================
*/

// Arduino Wire library is required if I2Cdev I2CDEV_ARDUINO_WIRE implementation
// is used in I2Cdev.h
#include "Wire.h"

// I2Cdev and MPU6050 must be installed as libraries, or else the .cpp/.h files
// for both classes must be in the include path of your project
#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h" // replaces and enhances the "MPU6050.h"


MPU6050 mpu;

//define OUTPUT_TEAPOT
#define ACCELERATION_FROM_FIFO
#define LED_PIN 13 // Using the LED to light up on any error (critical or non critical)


// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

// The button
const int buttonPin = 12;
const int ledPin =  13;            // the number of the LED pin
int buttonFinalState = 0;          // 0 - off, 1 - on
int buttonPreviousState = HIGH;       // 0 - no action, 1 - button tapped once, 2 - button tapped twice
int longPressInterval = 3000;     // the treshhold in mili seconds defining when it was a double and when a single tap
unsigned long buttonPressStartMillisec = 0;
int buttonPressCount = 0;
bool wasSend = true;    // check if the state update was send


// orientation/motion vars (not all are needed in this demo)
Quaternion q;           // [w, x, y, z]         quaternion container
VectorInt16 aa;         // [x, y, z]            accel sensor measurements
VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            gravity vector
float euler[3];         // [psi, theta, phi]    Euler angle container
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector

// packet structure for InvenSense teapot demo
uint8_t teapotPacket[8] = { 0,0, 0,0, 0,0, 0,0 };

// packet structure for the AccelerometerDemo
uint8_t accelerometerPacket[6] = { 0,0, 0,0,  0,0 };

int interval = 30;
unsigned long previousMillis = 0;




// ================================================================
// ===               INTERRUPT DETECTION ROUTINE                ===
// ================================================================

volatile bool mpuInterrupt = true;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
    mpuInterrupt = true;
}



// ================================================================
// ===                      INITIAL SETUP                       ===
// ================================================================

void setup() {

  pinMode(LED_PIN, OUTPUT);

  Wire.begin();
  Serial.begin(57600);
  while (!Serial); // wait for Leonardo enumeration, others continue immediately
/*    mpu.setXAccelOffset(-3902);
    mpu.setYAccelOffset(71);
    mpu.setZAccelOffset(4812);

    mpu.setXGyroOffset(4);
    mpu.setYGyroOffset(3);
    mpu.setZGyroOffset(25);
    */
    
    /* 
    // CALIBRATION FORM 03.06.2014 
    mpu.setXAccelOffset(-2424);
    mpu.setYAccelOffset(-1631);
    mpu.setZAccelOffset(610);

    mpu.setXGyroOffset(90);
    mpu.setYGyroOffset(1);
    mpu.setZGyroOffset(-40);
    */
    // CALIBRATION FORM 04.07.2014 
    mpu.setXAccelOffset(-2503);
    mpu.setYAccelOffset(-1766);
    mpu.setZAccelOffset(610);

    mpu.setXGyroOffset(100);
    mpu.setYGyroOffset(-5);
    mpu.setZGyroOffset(-45);
    
  // initialize device
  mpu.initialize();

  // verify connection
//  Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

  // DEAD: wait for ready
  //Serial.println(F("\nSend any character to begin DMP programming and demo: "));
  //while (Serial.available() && Serial.read()); // empty buffer
  //while (!Serial.available());                 // wait for data
  //while (Serial.available() && Serial.read()); // empty buffer again

  // load and configure the DMP
  devStatus = mpu.dmpInitialize();
    
  // make sure it worked (returns 0 if so)
  if (devStatus == 0) {
    // turn on the DMP, now that it's ready
    mpu.setDMPEnabled(true);

    // enable Arduino interrupt detection
    attachInterrupt(0, dmpDataReady, RISING);
    mpuIntStatus = mpu.getIntStatus();

    // set our DMP Ready flag so the main loop() function knows it's okay to use it
    dmpReady = true;

    // get expected DMP packet size for later comparison
    packetSize = mpu.dmpGetFIFOPacketSize();
  }
  else {
    // ERROR!
    // 1 = initial memory load failed
    // 2 = DMP configuration updates failed
    // (if it's going to break, usually the code will be 1)
    digitalWrite(LED_PIN, HIGH);
    //Serial.print(F("DMP Initialization failed (code "));
    //Serial.print(devStatus);
    //Serial.println(F(")"));
  }

  // Set up the button
  pinMode(buttonPin, INPUT_PULLUP);
}



// ================================================================
// ===                    MAIN PROGRAM LOOP                     ===
// ================================================================

void loop() {
    // if programming failed, don't try to do anything
    if (!dmpReady) return;
   // digitalWrite(LED_PIN, HIGH);
    // BUTTON ACTION
    int buttonState = digitalRead(buttonPin);
    if (buttonState == HIGH)
      digitalWrite(LED_PIN, HIGH);
    if (buttonState == LOW) 
      digitalWrite(LED_PIN, LOW);
    
    // if changed state
 /*   if (buttonPreviousState != buttonState) {
      wasSend = false;
      // if button is pressed now
      if (buttonState == LOW) {
        buttonPressStartMillisec = millis();
      } else {
        if ( (millis() - buttonPressStartMillisec) < longPressInterval ) {
          buttonFinalState = 1;
        } else {
          buttonFinalState = 2;
        }
      }
    } else {
      buttonFinalState = 0;
    }
    buttonPreviousState = buttonState;
    */
      
    // reset interrupt flag and get INT_STATUS byte
    mpuInterrupt = false;
    mpuIntStatus = mpu.getIntStatus();

    // get current FIFO count
    fifoCount = mpu.getFIFOCount();

    // check for overflow (this should never happen unless our code is too inefficient)
    if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
        // reset so we can continue cleanly
        mpu.resetFIFO();
        digitalWrite(LED_PIN, HIGH);
        //Serial.println(F("FIFO overflow!"));

    // otherwise, check for DMP data ready interrupt (this should happen frequently)
    } else if (mpuIntStatus & 0x02) {
        // wait for correct available data length, should be a VERY short wait
        while (fifoCount < packetSize) fifoCount = mpu.getFIFOCount();

        // read a packet from FIFO
        mpu.getFIFOBytes(fifoBuffer, packetSize);
        
        // track FIFO count here in case there is > 1 packet available
        // (this lets us immediately read more without waiting for an interrupt)
        fifoCount -= packetSize;


// -------------------- Define segments. Most are removed as unnecessary for this demo        
        accelerometerPacket[0] = fifoBuffer[28]; // X
        accelerometerPacket[1] = fifoBuffer[29];
        accelerometerPacket[2] = fifoBuffer[32]; // Y
        accelerometerPacket[3] = fifoBuffer[33];
        accelerometerPacket[4] = fifoBuffer[36]; // Z
        accelerometerPacket[5] = fifoBuffer[37];
        // display quaternion values in InvenSense Teapot demo format:
        teapotPacket[0] = fifoBuffer[0];
        teapotPacket[1] = fifoBuffer[1];
        teapotPacket[2] = fifoBuffer[4];
        teapotPacket[3] = fifoBuffer[5];
        teapotPacket[4] = fifoBuffer[8];
        teapotPacket[5] = fifoBuffer[9];
        teapotPacket[6] = fifoBuffer[12];
        teapotPacket[7] = fifoBuffer[13];
        
        unsigned long currentMillis = millis();
        
        if(currentMillis - previousMillis > interval) {
            previousMillis = currentMillis;
            // header
            Serial.write(85);  // 85 == 01010101xb
            // button tapped
            Serial.write(buttonState);
            wasSend = true;
            // acceleration
            Serial.write(accelerometerPacket, 6);
            // orientation - quaternions
            Serial.write(teapotPacket, 8);
            // end of package
            Serial.write(170);  // 170 == 10101010xb
            
          /*  VectorInt16 gyro;
            VectorInt16 aa;
            VectorInt16 aaReal;
            VectorInt16 aaWorld;
            VectorFloat gravity;
            Quaternion q;
            
            mpu.dmpGetQuaternion(&q, fifoBuffer);
            mpu.dmpGetGravity(&gravity, &q);
            mpu.dmpGetAccel(&aa);
            mpu.dmpGetLinearAccel(&aaReal, &aa, &gravity);
            mpu.dmpGetLinearAccelInWorld(&aaWorld, &aaReal, &q);
            
            Serial.println("raw acceleration :");
            Serial.println( (short)(accelerometerPacket[0] << 8) | accelerometerPacket[1] );
            Serial.println( (short)(accelerometerPacket[2] << 8) | accelerometerPacket[2] );
            Serial.println( (short)(accelerometerPacket[4] << 8) | accelerometerPacket[3] ); 
            Serial.println("gravity form MPU");
            Serial.println( gravity.x);
            Serial.println( gravity.y);
            Serial.println( gravity.z);
            Serial.println("linear acceleration");
            Serial.println( aaReal.x);
            Serial.println( aaReal.y);
            Serial.println( aaReal.z);
            Serial.println("linear acceleration world");
            Serial.println( aaWorld.x);
            Serial.println( aaWorld.y);
            Serial.println( aaWorld.z); 
            */
            
            teapotPacket[11]++; // packetCount, loops at 0xFF on purpose
            Serial.write(0);
        }
  }
  
//  buttonPreviousState = buttonState;
}








