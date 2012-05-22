#!/sbin/busybox sh

INSTALLDIR="/sbin/xx"
FILESDIR="$INSTALLDIR/files"

#### Install liblights ####
LIGHTS="lights.exynos4.so"
mv -f $FILESDIR/liblights/$LIGHTS /system/lib/hw/$LIGHTS
chmod 644 /system/lib/hw/$LIGHTS


#### Done with /system ####
mount /system -o remount,ro


#### Install xxTweaker ####
if [ ! -e /data ]; then mount /data -o remount,rw; fi

# Create data directory with correct permissions
if [ ! -e /data/data/net.fluxi.xxTweaker/shared_prefs/net.fluxi.xxTweaker_preferences.xml ]; then
	rm -rf /data/data/net.fluxi.xxTweaker
	mkdir -p /data/data/net.fluxi.xxTweaker/shared_prefs
fi

# Leave it up to the user
if [ ! -e "/data/.notweaker" ]; then
	# Copy file
	mv -f $FILESDIR/xxTweaker/xxTweaker.apk /data/app/net.fluxi.xxTweaker-1.apk
	chmod 644 /data/app/net.fluxi.xxTweaker-1.apk
	# Needed, else CM settings will turn on touchkeys when dimming the screen
	touch "/data/.disable_touchlight"
fi


#### Create /clockworkmod/.salted_hash to satisfy CWMR ####
while [ ! -e /mnt/emmc/.android_secure ]; do sleep 2; done
if [ ! -e /mnt/emmc/clockworkmod ]; then
	mkdir -p /mnt/emmc/clockworkmod/backup
	touch /mnt/emmc/clockworkmod/.salted_hash
fi

while [ ! -e /mnt/sdcard/.android_secure ]; do sleep 2; done
if [ ! -e /mnt/sdcard/clockworkmod ]; then
	mkdir -p /mnt/sdcard/clockworkmod/backup
	touch /mnt/sdcard/clockworkmod/.salted_hash
fi

