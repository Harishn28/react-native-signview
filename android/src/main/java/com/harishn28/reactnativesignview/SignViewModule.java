package com.harishn28.reactnativesignview;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.NativeViewHierarchyManager;
import com.facebook.react.uimanager.UIBlock;
import com.facebook.react.uimanager.UIManagerModule;

public class SignViewModule extends ReactContextBaseJavaModule {
    public SignViewModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "SignViewModule";
    }

    @ReactMethod
    public void clearSignature(final int viewTag){
        Log.d("test","---------clear sginature");
        ReactApplicationContext context = getReactApplicationContext();
        UIManagerModule uiManager = context.getNativeModule(UIManagerModule.class);
        uiManager.addUIBlock(new UIBlock() {
            @Override
            public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                try{
                    SignatureView signatureView = (SignatureView)nativeViewHierarchyManager.resolveView(viewTag);
                    signatureView.clearSignature();
                }catch (Exception ex){

                }
            }
        });
    }
}
