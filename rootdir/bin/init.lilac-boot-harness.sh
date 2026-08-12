#!/vendor/bin/sh
DIR=/mnt/vendor/persist/boot_harness
MARK=$DIR/boot_attempt
THRESHOLD=2

mkdir -p $DIR 2>/dev/null

if [ -f $MARK ]; then
    n=$(cat $MARK 2>/dev/null)
else
    n=0
fi
case "$n" in
    ''|*[!0-9]*) n=0 ;;
esac

if [ "$n" -ge "$THRESHOLD" ]; then
    rm -f $MARK 2>/dev/null
    setprop sys.powerctl reboot,recovery
    exit 0
fi

echo $((n + 1)) > $MARK
sync
