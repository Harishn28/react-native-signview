package com.harishn28.reactnativesignview;

import android.content.Context;

public interface SignViewCallbacks {
    void onSignAvailable(Context context, int targetId, String base64DataOfSign);
}