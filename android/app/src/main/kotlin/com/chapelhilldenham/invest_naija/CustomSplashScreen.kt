package com.chapelhilldenham.invest_naija

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.annotation.Nullable
import io.flutter.embedding.android.SplashScreen


class CustomSplashScreen : SplashScreen {
    @Nullable
    override fun createSplashView(
            context: Context,
            @Nullable savedInstanceState: Bundle?
    ): View {
        return SplashView(context)
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}