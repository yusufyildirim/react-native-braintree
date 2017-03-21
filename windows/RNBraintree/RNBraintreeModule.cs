using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RNBraintree
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNBraintreeModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNBraintreeModule"/>.
        /// </summary>
        internal RNBraintreeModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNBraintree";
            }
        }
    }
}
