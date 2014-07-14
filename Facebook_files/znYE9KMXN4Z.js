/*!CK:1228427672!*//*1401953710,178171423*/

if (self.CavalryLogger) { CavalryLogger.start_js(["6BJiY"]); }

__d("legacy:control-textarea",["TextAreaControl"],function(a,b,c,d){a.TextAreaControl=b('TextAreaControl');},3);
__d("EventsCreateAction",["Form","DOM","Event","CSS","cx","Arbiter","bind"],function(a,b,c,d,e,f,g,h,i,j,k,l,m){var n={initDialog:function(o,p,q){this._dialog=o;if(!p)return;l.subscribe('EventEditDialogShow/aftershow',function(){var r=h.find(o.getContentRoot(),"button.createButtonFromCreateDialog");i.listen(r,'click',m(this,function(s){var t=g.serialize(o.getRoot()).category_id,u=g.serialize(o.getRoot()).title;if(!t||t=="null"){if(u)s.preventDefault();var v=h.find(o.getContentRoot(),"tr."+"_4zji");j.show(v);}}));}.bind(this));},hideWarning:function(){if(!this._dialog)return;var o=h.find(this._dialog.getContentRoot(),"tr."+"_4zji");if(o)j.hide(o);}};e.exports=n;},null);