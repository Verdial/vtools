#!/system/bin/sh
setenforce 0
action=$1
if [ ! `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor` = "interactive" ]; then 
	sh /system/etc/init.qcom.post_boot.sh
fi

#echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis

#powersave 1.2Ghz
if [ "$action" = "powersave" ]; then
	echo "0" > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms

	echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus

	echo "75" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "87 729600:95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "0:1036800 1:1036800 2:1036800 3:1036800 4:1056000 5:1056000 6:1056000 7:1056000" > /sys/module/msm_performance/parameters/cpu_max_freq
	echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 50000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	
	echo 672000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo 729600 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	
	echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 100000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 8 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
	echo 6 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 8 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
	echo 0 > /proc/sys/kernel/sched_boost

	echo 0 > /sys/module/msm_thermal/core_control/enabled
	echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
	echo N > /sys/module/msm_thermal/parameters/enabled
	exit 0
fi

echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
echo 1 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu7/online

# Enable input boost configuration
echo "0:960000" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
echo "78 1804800:95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo "83 1939200:90 2016000:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads

if [ "$action" = "balance" ]; then
	echo "0:1248000 1:1248000 2:1248000 3:1248000 4:1497600 5:1497600 6:1497600 7:1497600" > /sys/module/msm_performance/parameters/cpu_max_freq
	echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 100000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 1497600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	
	echo 748000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq

	echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 100000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 8 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
	echo 6 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 8 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
	echo 0 > /proc/sys/kernel/sched_boost

	echo 0 > /sys/module/msm_thermal/core_control/enabled
	echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
	echo N > /sys/module/msm_thermal/parameters/enabled

	exit 0
fi

if [ "$action" = "performance" ]; then
	echo "0:1555200 1:1555200 2:1555200 3:1555200 4:2035200 5:2035200 6:2035200 7:2035200" > /sys/module/msm_performance/parameters/cpu_max_freq
	echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1555200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 100000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 2035200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

	echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo 1267200 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq

	echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 257000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 8 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 6 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
	echo 0 > /proc/sys/kernel/sched_boost

	echo 0 > /sys/module/msm_thermal/core_control/enabled
	echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
	echo N > /sys/module/msm_thermal/parameters/enabled

	exit 0
fi

if [ "$action" = "fast" ]; then
	echo "0:2750000 1:2750000 2:2750000 3:2750000 4:2750000 5:2750000 6:2750000 7:2750000" > /sys/module/msm_performance/parameters/cpu_max_freq
	echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 2750000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 1267200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 2750000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	
	echo 1747200 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo 2035200 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	
	echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 850000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 257000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 8 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 5 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
	echo 1 > /proc/sys/kernel/sched_boost

	echo 0 > /sys/module/msm_thermal/core_control/enabled
	echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
	echo Y > /sys/module/msm_thermal/parameters/enabled
	
	exit 0
fi
