//
//  NZClassificationController.m
//  Gesture
//
//  Created by Natalia Zarawska on 11/11/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZClassificationController.h"


@interface NZClassificationController ()


@end

@implementation NZClassificationController

GRT::DTW _dtw;
GRT::DTW _trainingDtw;

GRT::TimeSeriesClassificationData _trainingData;
GRT::TimeSeriesClassificationData _dataToBeClassified;

/**
 * for each gesture stores the value if it is trained or needs training
 */
std::map<GRT::UINT, bool> _isTrained;


/**
 * all the DTWTemplates for the gestures
 */
std::map<GRT::UINT, GRT::DTWTemplate> _dtwTemplates;


#pragma mark - init
- (instancetype)initWithClassifier:(GRT::DTW)dtw;
{
    self = [super init];
    if (self) {
        _dtw = GRT::DTW(dtw);
        _trainingDtw = GRT::DTW(dtw);
        _trainingData = GRT::TimeSeriesClassificationData();
        _isTrained = std::map<GRT::UINT, bool>();
        _dtwTemplates = std::map<GRT::UINT, GRT::DTWTemplate>();
    }
    return self;
}

- (instancetype)initFromFile:(NSString *)fileName
{
    self = [super init];
    if (self) {
        _dtw = GRT::DTW();
        
        NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [searchPath objectAtIndex:0];
        NSString *classifierPath = [documentPath stringByAppendingPathComponent:fileName];
        _dtw.loadModelFromFile([classifierPath UTF8String]);
        _trainingDtw = GRT::DTW(_dtw);
        _trainingDtw.reset();
        _trainingData = GRT::TimeSeriesClassificationData();
        _isTrained = std::map<GRT::UINT, bool>();
        _dtwTemplates = std::map<GRT::UINT, GRT::DTWTemplate>();
        std::vector<GRT::DTWTemplate> templates = _dtw.getModels();
        for (int i = 0; i < templates.size(); i++) {
            _dtwTemplates.insert(std::pair<GRT::UINT, GRT::DTWTemplate>(templates[0].classLabel, templates[0]));
            _isTrained.insert(std::pair<GRT::UINT, BOOL>(templates[0].classLabel, true));
        }
    }
    return self;
    
}

#pragma mark - training related

- (bool)train
{
    bool res = true;
    
    for (std::map<GRT::UINT, bool>::iterator it = _isTrained.begin(); it != _isTrained.end() && res; it++) {
        res = [self trainGestureWithLabel:it->first];
    }
    
    // check if the #templates in _dtw is equal to the current #gestures
    if (_dtw.getNumTemplates() != _dtwTemplates.size()) {
        GRT::TimeSeriesClassificationData dummyData = GRT::TimeSeriesClassificationData(_trainingData.getNumDimensions());
        GRT::MatrixDouble dummy(1, _trainingData.getNumClasses());
        for (int i = 0; i < _trainingData.getNumDimensions(); i++) {
            dummy[0][i] = 0;
        }
        for (int i = 0; i < _trainingData.getNumClasses(); i++) {
            dummyData.addSample(i, dummy);
        }
        _dtw.train(dummyData);
        _dtw.setModels([self templatesToVector:_dtwTemplates]);
    }
    return res;
}

-(bool)trainGestureWithLabel:(GRT::UINT)label
{
    std::map<GRT::UINT, bool>::iterator it = _isTrained.find(label);
    if (it == _isTrained.end()) {
        NSLog(@"Failed to train gesture %d .No gesture with the given label found.", label);
        return false;
    }
    if (it->second == true) {
        NSLog(@"Gesture %d is already trained.", label);
        return true;
    }
    
    // get the traing samples for that gesture
    GRT::TimeSeriesClassificationData classificationDataForGesture = _trainingData.getClassData(label);
    bool res = _trainingDtw.train(classificationDataForGesture);
    
    if (!res) {
        NSLog(@"unable to train gesture!");
        return res;
    }
    it->second = true;
    GRT::DTWTemplate dtwTemplate = _trainingDtw.getModels()[0];
    std::map<GRT::UINT, GRT::DTWTemplate>::iterator itTemplates = _dtwTemplates.find(label);
    if (itTemplates == _dtwTemplates.end()) {
        _dtwTemplates.insert(std::pair<GRT::UINT, GRT::DTWTemplate>(label, dtwTemplate));
    } else {
        itTemplates->second = dtwTemplate;
    }
    
    return res;
}

- (void)addTrainindSample:(GRT::MatrixDouble)sample withLabel:(GRT::UINT)label
{
    _trainingData.addSample(label, sample);
    std::map<GRT::UINT, bool>::iterator it = _isTrained.find(label);
    if (it == _isTrained.end()) {
        _isTrained.insert(std::pair<GRT::UINT, bool>(label, false));
    } else
        it->second = false;
}

- (void)removeAllSamplesWithLable:(GRT::UINT)classLabel
{
    _isTrained.erase(classLabel);
    _dtwTemplates.erase(classLabel);
    _trainingData.eraseAllSamplesWithClassLabel(classLabel);
}

- (int)predict:(GRT::MatrixDouble)data
{
    bool res = _dtw.predict(data);
    if (!res) {
        return -1;
    }
    return _dtw.getPredictedClassLabel();
}

- (bool)saveClassifierToFileWithName:(NSString *)name
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPath objectAtIndex:0];
    NSString *classifierPath = [documentPath stringByAppendingPathComponent:name];
    return _dtw.saveModelToFile( [classifierPath UTF8String]);

}

#pragma mark - setters & getters
- (void)setTrainingData:(GRT::TimeSeriesClassificationData)trainingData
{
    _trainingData = GRT::TimeSeriesClassificationData(trainingData);
}

#pragma mark - helper functions
- (std::vector<GRT::DTWTemplate>)templatesToVector: (std::map<GRT::UINT, GRT::DTWTemplate>) templates
{
    std::vector<GRT::DTWTemplate> templatesV;
    for (std::map<GRT::UINT, GRT::DTWTemplate>::iterator it = templates.begin(); it != templates.end() ;it++) {
        templatesV.push_back(it->second);
    }
    return templatesV;
    
};

@end
