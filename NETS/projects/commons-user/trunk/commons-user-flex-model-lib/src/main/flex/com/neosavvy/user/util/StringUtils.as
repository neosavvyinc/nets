package com.neosavvy.user.util {
     import mx.utils.StringUtil;

    public class StringUtils {

        public static const INVALID_AMOUNT_NUMBER:String = '--.--';
        public static const INVALID_TIME_NUMBER:String = '--:--';
        public static const INVALID_NUMBER:String = '--';
        public static const INVALID_INPUT_NUMBER:String = '';
        public static const INVALID_NAME:String = '--';
        public static const INVALID_EMAIL:String = '--@--.--';
        public static const INVALID_PHONE_NUMBER:String = 'xxx-xxx-xxxx';

        public static const BYTES_GIGABYTE:int = 1024 * 1024 * 1024;
        public static const BYTES_MEGABYTE:int = 1024 * 1024;
        public static const BYTES_KILOBYTE:int = 1024;

        public static function isValidEmail(email:String):Boolean
        {
            var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
            return emailExpression.test(email);
        }

        public static function toNumber(value:String):Number {
            if (StringUtils.isEmpty(value)) {
                return NaN;
            }

            return Number(value);
        }

        public static function isEmpty(value:String):Boolean {
            return value == null || StringUtil.trim(value).length == 0;
        }

        public static function formatAmount(amount:Number):String {
            if (isNaN(amount)) {
                return INVALID_AMOUNT_NUMBER;
            }

            return amount.toFixed(2);
        }

        public static function formatNumber(number:Number, precision:int, invalidReplacement:String = INVALID_NUMBER):String {
            if (isNaN(number)) {
                return invalidReplacement;
            }

            if (precision == 0) {
                return String(int(number));
            }

            return number.toFixed(precision);
        }


        public static function compare(string1:String, string2:String):int {
            var result:int = string1.localeCompare(string2);

            if (result < 0) {
                return -1;
            }
            else if (result == 0) {
                return 0;
            }

            return 1;
        }

        public static function formatBytes(bytes:uint):String {
            if (bytes >= BYTES_GIGABYTE) {
                return formatNumber(bytes / BYTES_GIGABYTE, 2) + ' GB';
            }
            else if (bytes >= BYTES_MEGABYTE) {
                return formatNumber(bytes / BYTES_MEGABYTE, 2) + ' MB';
            }
            if (bytes >= BYTES_KILOBYTE) {
                return formatNumber(bytes / BYTES_KILOBYTE, 0) + ' KB';
            }

            return String(bytes);
        }

        public static function getFileExtension(fileName:String):String {
            var position:int = fileName.lastIndexOf('.');

            if (position > 0) {
                return fileName.substr(position + 1);
            }

            return '';
        }

        public static function normalizeNewLines(s:String):String {
            return s.replace(/\r\n?/ig, "\n");
        }

        public static function parseXmlDateTime(dateStr:String):Date {
            var date:String = dateStr;
            var time:String = '00:00:00';
            var timeZone:String = '0000';
            var i:int = dateStr.indexOf('T');
            if (i > 0) {
                date = dateStr.substring(0, i);
                var timeAndZone:String = dateStr.substring(i + 1);
                i = timeAndZone.indexOf('-');
                if (i == -1) {
                    i = timeAndZone.indexOf('+');
                }
                if (i > 0) {
                    time = timeAndZone.substring(0, i);
                    timeZone = timeAndZone.substring(i + 1);
                }
                else {
                    time = timeAndZone;
                }

                i = time.indexOf('.');
                if (i > 0) {
                    time = time.substring(0, i);
                }
            }
            date = date.replace(/-/g, "/");
            timeZone = timeZone.replace(":", "");
            const val:Number = Date.parse(date + " " + time + " GMT-" + timeZone);

            if (!val || val < 0)
            {
                return null;
            }
            else
            {
                return new Date(val);
            }
        }

    }
}