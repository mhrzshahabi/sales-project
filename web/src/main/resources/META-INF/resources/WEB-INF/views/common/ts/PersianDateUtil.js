//------------------------------------------ TS References -----------------------------------------
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var PersianDateUtil = /** @class */ (function () {
        function PersianDateUtil() {
        }
        // external usage
        PersianDateUtil.minDate = function (dates) {
            var _this = this;
            if (dates == null || dates.length === 0)
                return "";
            return dates.map(function (q) { return Number(_this.formatDateToNumberStr(q)); }).min().toString();
        };
        // external usage
        PersianDateUtil.maxDate = function (dates) {
            var _this = this;
            if (dates == null || dates.length === 0)
                return "";
            return dates.map(function (q) { return Number(_this.formatDateToNumberStr(q)); }).max().toString();
        };
        // external usage
        PersianDateUtil.compareDate = function (first, second) {
            var firstValue = this.formatDateToNumberStr(first);
            var secondValue = this.formatDateToNumberStr(second);
            return Number(firstValue) - Number(secondValue);
        };
        // external usages
        PersianDateUtil.isBetweenDate = function (date, first, second) {
            var dateValue = this.formatDateToNumberStr(date);
            var firstValue = this.formatDateToNumberStr(first);
            var secondValue = this.formatDateToNumberStr(second);
            return dateValue >= firstValue && dateValue <= secondValue;
        };
        // external usage
        PersianDateUtil.formatDate = function (date) {
            if (date == null || date === "")
                return "";
            return date.split('/').map(function (value, index) {
                if (index === 0)
                    return value.padStart(4, "0");
                else
                    return value.padStart(2, "0");
            }).join("/");
        };
        // external usage
        PersianDateUtil.formatDateToNumberStr = function (date) {
            if (date == null || date === "")
                return "";
            return date.split('/').map(function (value, index) {
                if (index === 0)
                    return value.padStart(4, "0");
                else
                    return value.padStart(2, "0");
            }).join("");
        };
        return PersianDateUtil;
    }());
    nicico.PersianDateUtil = PersianDateUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
