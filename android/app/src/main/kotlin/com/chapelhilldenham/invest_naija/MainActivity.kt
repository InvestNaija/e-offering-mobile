package com.chapelhilldenham.invest_naija

import androidx.annotation.Nullable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity: FlutterActivity() {
    @Nullable
    override fun provideSplashScreen(): SplashScreen {
        return CustomSplashScreen()
    }
}
