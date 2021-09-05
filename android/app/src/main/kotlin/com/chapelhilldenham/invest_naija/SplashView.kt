package com.chapelhilldenham.invest_naija

import android.content.Context
import android.graphics.Typeface
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.res.ResourcesCompat




class SplashView(context: Context) : LinearLayout(context) {

    private var add: ImageView

    init {
        val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val view = inflater.inflate(R.layout.custom_splash_screen_layout, this, true)
        add = view.findViewById(R.id.logo)
    }



    inner class SplashViewAdapter(context: Context?, var resource: Int, var objects: MutableList<String>?) : ArrayAdapter<String>(context!!, resource, objects as MutableList<String>) {
        private val inflater: LayoutInflater = LayoutInflater.from(context)
        override fun getCount(): Int {
            return objects!!.size
        }

        override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
            return inflater.inflate(resource, parent, false)
        }
    }
}