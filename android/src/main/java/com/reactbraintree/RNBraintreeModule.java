
package com.reactbraintree;

import android.app.Activity;
import android.content.Intent;
import android.widget.Toast;

import com.braintreepayments.api.dropin.DropInActivity;
import com.braintreepayments.api.dropin.DropInRequest;
import com.braintreepayments.api.dropin.DropInResult;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNBraintreeModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private Callback successCallback;
  private Callback cancelCallback;

  private Promise braintreePromise;

  private static final int REQUEST_CODE = 1;
  private static final String CANCELED = "CANCELED";
  private static final String ERROR = "ERROR";
  private String token;

  public RNBraintreeModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    reactContext.addActivityEventListener(new BraintreeActivityListener());
  }

  @Override
  public String getName() {
    return "RNBraintree";
  }

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

  @ReactMethod
  public void init(String token) {
    this.setToken(token);
  }

  @ReactMethod
  public void showDropIn(final Promise promise) {
    this.braintreePromise = promise;

    if(this.getToken() == null) {
      promise.reject(ERROR, "You must call init method first!");
    } else {
      DropInRequest dropInRequest = new DropInRequest().clientToken(this.getToken());

      getCurrentActivity().startActivityForResult(dropInRequest.getIntent(getCurrentActivity()), REQUEST_CODE);
    }
  }

  private class BraintreeActivityListener extends BaseActivityEventListener {
    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
      if (requestCode == REQUEST_CODE) {
        if (resultCode == Activity.RESULT_OK) {
          DropInResult result = data.getParcelableExtra(DropInResult.EXTRA_DROP_IN_RESULT);

          braintreePromise.resolve(result.getPaymentMethodNonce().getNonce());

          // use the result to update your UI and send the payment method nonce to your server
        } else if (resultCode == Activity.RESULT_CANCELED) {
          // the user canceled

          braintreePromise.reject(CANCELED, "Drop In was canceled.");
        } else {
          // handle errors here, an exception may be available in
          Exception error = (Exception) data.getSerializableExtra(DropInActivity.EXTRA_ERROR);
          braintreePromise.reject(ERROR, error.getMessage());
        }
      }
    }
  }

}