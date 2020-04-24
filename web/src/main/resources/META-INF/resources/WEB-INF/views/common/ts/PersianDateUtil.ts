//------------------------------------------ TS References -----------------------------------------

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class PersianDateUtil {

        // external usage
        static minDate(dates: Array<string>): string {

            if (dates == null || dates.length === 0) return "";
            return dates.map(q => Number(this.formatDateToNumberStr(q))).min().toString();
        }

        // external usage
        static maxDate(dates: Array<string>): string {

            if (dates == null || dates.length === 0) return "";
            return dates.map(q => Number(this.formatDateToNumberStr(q))).max().toString();
        }

        // external usage
        static compareDate(first: string, second: string): number {

            let firstValue = this.formatDateToNumberStr(first);
            let secondValue = this.formatDateToNumberStr(second);
            return Number(firstValue) - Number(secondValue);
        }

        // external usages
        static isBetweenDate(date: string, first: string, second: string): boolean {

            let dateValue = this.formatDateToNumberStr(date);
            let firstValue = this.formatDateToNumberStr(first);
            let secondValue = this.formatDateToNumberStr(second);
            return dateValue >= firstValue && dateValue <= secondValue;
        }

        // external usage
        static formatDate(date: string): string {

            if (date == null || date === "") return "";
            return date.split('/').map((value, index) => {

                if (index === 0) return value.padStart(4, "0");
                else return value.padStart(2, "0");
            }).join("/");
        }

        // external usage
        static formatDateToNumberStr(date: string): string {

            if (date == null || date === "") return "";
            return date.split('/').map((value, index) => {

                if (index === 0) return value.padStart(4, "0");
                else return value.padStart(2, "0");
            }).join("");
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
