package com.omarea.ui

import android.content.Context
import android.graphics.drawable.Drawable
import android.support.design.widget.Snackbar
import android.view.View
import android.view.ViewGroup
import android.widget.*

import com.omarea.shared.Appinfo
import com.omarea.vboot.R
import kotlinx.android.synthetic.main.layout_applictions.*
import java.util.ArrayList
import java.util.HashMap

/**
 * Created by Hello on 2018/01/26.
 */

class AppListAdapter(private val context: Context, apps: ArrayList<Appinfo>, private var keywords: String = "") : BaseAdapter() {
    private val list: ArrayList<Appinfo>?
    var states = HashMap<Int, Boolean>()

    private var viewHolder: AppListAdapter.ViewHolder? = null

    init {
        this.list = sortAppList(filterAppList(apps, keywords))
        for (i in list.indices) {
            states[i] = !(list[i].enabledState == null || !list[i].selectState)
        }
    }

    override fun getCount(): Int {
        return list?.size ?: 0
    }

    override fun getItem(position: Int): Appinfo {
        return list!![position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    private fun filterAppList(appList: ArrayList<Appinfo>, keywords: String): ArrayList<Appinfo> {
        val text = keywords.toLowerCase()
        if (text.isEmpty())
            return appList
        return java.util.ArrayList(appList.filter { item ->
            item.packageName.toString().toLowerCase().contains(text) || item.appName.toString().toLowerCase().contains(text)
        })
    }

    private fun sortAppList(list: ArrayList<Appinfo>): ArrayList<Appinfo> {
        list.sortWith(Comparator { l, r ->
            val wl = l.wranState.toString()
            val wr = r.wranState.toString()
            when {
                wl.isNotEmpty() && wr.isEmpty() -> 1
                wr.isNotEmpty() && wl.isEmpty() -> -1
                else -> {
                    val les = l.enabledState.toString()
                    val res = r.enabledState.toString()
                    when {
                        les < res -> -1
                        les > res -> 1
                        else -> {
                            val lp = l.packageName.toString()
                            val rp = r.packageName.toString()
                            when {
                                lp < rp -> -1
                                lp > rp -> 1
                                else -> 0
                            }
                        }
                    }
                }
            }
        })
        return list
    }

    fun getSelectedItems(): ArrayList<Appinfo> {
        val states = states
        val selectedItems = states.keys
                .filter { states[it] == true }
                .mapTo(ArrayList<Appinfo>()) { getItem(it) }

        if (selectedItems.size == 0) {
            return ArrayList()
        }
        return selectedItems
    }

    override fun getView(position: Int, view: View?, parent: ViewGroup): View {
        var convertView = view
        if (convertView == null) {
            viewHolder = ViewHolder()
            convertView = View.inflate(context, R.layout.app_item2, null)
            viewHolder!!.itemTitle = convertView!!.findViewById(R.id.ItemTitle)
            viewHolder!!.enabledStateText = convertView.findViewById(R.id.ItemEnabledStateText)
            viewHolder!!.itemText = convertView.findViewById(R.id.ItemText)
            viewHolder!!.imgView = convertView.findViewById(R.id.ItemIcon)
            viewHolder!!.itemChecke = convertView.findViewById(R.id.select_state)
            viewHolder!!.wranStateText = convertView.findViewById(R.id.ItemWranText)
            convertView.tag = viewHolder
        } else {
            viewHolder = convertView.tag as ViewHolder
        }

        viewHolder!!.itemTitle!!.text = getItem(position).appName
        viewHolder!!.itemText!!.text = getItem(position).packageName
        viewHolder!!.imgView!!.setImageDrawable(getItem(position).icon)
        if (getItem(position).enabledState != null)
            viewHolder!!.enabledStateText!!.text = getItem(position).enabledState
        else
            viewHolder!!.enabledStateText!!.text = ""

        //为checkbox添加复选监听,把当前位置的checkbox的状态存进一个HashMap里面
        viewHolder!!.itemChecke!!.setOnCheckedChangeListener { buttonView, isChecked -> states[position] = isChecked }
        //从hashmap里面取出我们的状态值,然后赋值给listview对应位置的checkbox
        viewHolder!!.itemChecke!!.setChecked(states[position] == true)

        if (getItem(position).wranState != null)
            viewHolder!!.wranStateText!!.text = getItem(position).wranState
        else
            viewHolder!!.wranStateText!!.text = ""

        return convertView
    }

    inner class ViewHolder {
        internal var itemTitle: TextView? = null
        internal var itemChecke: CheckBox? = null
        internal var imgView: ImageView? = null
        internal var itemText: TextView? = null
        internal var enabledStateText: TextView? = null
        internal var wranStateText: TextView? = null
    }
}
