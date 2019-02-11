package com.harishn28.reactnativesignview;

import android.content.Context;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;

import java.util.Map;


public class SignViewManager extends SimpleViewManager<SignatureView> implements SignViewCallbacks {
    @Override
    public String getName() {
        return "SignView";
    }

    @Override
    protected SignatureView createViewInstance(ThemedReactContext reactContext) {
        SignatureView signView = new SignatureView(reactContext);
        signView.setSignViewCallbacks(this);
        return signView;
    }


    //SignView Callback functions
    @Override
    public void onSignAvailable(Context context, int targetId, String base64DataOfSign) {
        WritableMap event = Arguments.createMap();
        event.putString("signature", base64DataOfSign);
        ReactContext reactContext = (ReactContext)context;
        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                targetId,
                "onSignAvailable",
                event);
    }


    //JS View Properties(Properties passed from JS to Native
    @ReactProp(name = "signatureColor", customType = "color")
    public void setSignatureColor(SignatureView view, int color){
        view.setSignatureColor(color);
    }

    @ReactProp(name = "" +
            "" +
            "" +
            "")
    public void setStrokeWidth(SignatureView view, int strokeWidth){
        view.setSignatureColor(strokeWidth);
    }


    //Events passed from Native to JS.
    public Map getExportedCustomBubblingEventTypeConstants() {
        return MapBuilder.builder()
                .put(
                        "onSignAvailable",
                        MapBuilder.of(
                                "phasedRegistrationNames",
                                MapBuilder.of("bubbled", "onSignAvailable")))
                .build();
    }

}