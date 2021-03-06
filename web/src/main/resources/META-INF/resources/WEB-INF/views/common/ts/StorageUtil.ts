/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2019.full.d.ts"/>
/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2017.object.d.ts"/>
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts"/>
// <%@ page contentType="text/html;charset=UTF-8" %>
class StorageUtil {

    private static _prefix: string = 'sales';

    public static save(name, option): void {
        //option = typeof (option) === 'string' ? JSON.parse(option) : option;
        name = name.toString();
        const storage_name = this._prefix;
        let allOptions_str = localStorage.getItem(storage_name);
        if (allOptions_str === null || allOptions_str === undefined) allOptions_str = "{}";
        const allOptions: object = JSON.parse(allOptions_str)
        if (Object.keys(allOptions).indexOf(name) < 0 ||
            typeof (allOptions[name]) !== typeof (option) ||
            typeof (allOptions[name]) !== 'object'
        ) allOptions[name] = option
        try {
            Object.assign(allOptions[name], allOptions[name], option);
        } catch (e) {
            allOptions[name] = option
        }
        localStorage.setItem(storage_name, JSON.stringify(allOptions))
    };

    public static get(...args: string[]): any {
        const storage_name = this._prefix;
        let allOptions = localStorage.getItem(storage_name);
        if (allOptions === null || allOptions === undefined) return null;
        const all = JSON.parse(allOptions);
        let result = all;
        args.forEach(k => result = result[k])
        return result
    };

    public static delete(...args: string[]) {
        const storage_name = this._prefix;
        let allOptions = localStorage.getItem(storage_name);
        if (allOptions === null || allOptions === undefined) return true;
        const all = JSON.parse(allOptions);
        try {
            const forEval = 'delete all["' + args.join('"]["') + '"]'
            eval(forEval);
            localStorage.setItem(storage_name, JSON.stringify(all));
            return true;
        } catch (e) {
            console.error('storageUtil delete error', e);
            return false
        }
    }


}

class SalesBaseParameters {
    public static rootUrl = document.URL.split("?")[0].slice(-1) === "/"
        ? document.URL.split("?")[0].slice(0, -1)
        : document.URL.split("?")[0];
    public static httpHeaders = {"Authorization": "Bearer <%= accessToken %>"};
    private static unit;
    private static warehouse;
    private static materialItem;

    static async getParameter(parameter: string, updateTable: boolean = false) {
        if (updateTable) {
            const dialog = isc.Dialog.create({
                title: "<spring:message code='global.please.wait'/>",
                message: "<spring:message code='global.this.may.takes.a.while'/>"
            });
            await fetch(this.rootUrl + '/api/' + parameter + '/update-all', {headers: this.httpHeaders});
            await this.fetchAndSave(parameter);
            dialog.close()
        } else if (!this[parameter]) {
            const parameters = StorageUtil.get('parameters');
            if (!parameters || !parameters[parameter]) {
                await this.fetchAndSave(parameter)
            } else this[parameter] = parameters[parameter];
        }
        return await this[parameter];
    }

    static async getUnitParameter(updateTable: boolean = false) {
        return await this.getParameter('unit', updateTable)
    }

    static getSavedWarehouseParameter() {
        return this.warehouse;
    }

    static getSavedUnitParameter() {
        return this.unit
    }

    static getSavedMaterialItemParameter() {
        return this.materialItem
    }

    static getAllSavedParameter() {
        return {
            'materialItem': this.materialItem,
            'unit': this.unit,
            'warehouse': this.warehouse
        }
    }

    static async getWarehouseParameter(updateTable: boolean = false) {
        return await this.getParameter('warehouse', updateTable)
    }

    static async getMaterialItemParameter(updateTable: boolean = false) {
        return await this.getParameter('materialItem', updateTable)
    }

    public static async getAllParameters(updateTable: boolean = false) {
        await Promise.all([
            this.getUnitParameter(updateTable),
            this.getWarehouseParameter(updateTable),
            this.getMaterialItemParameter(updateTable)
        ]);
        return {
            'materialItem': this.materialItem,
            'unit': this.unit,
            'warehouse': this.warehouse
        }
    }

    private static async fetchAndSave(parameter: string) {
        try {
            const rawResponse = await fetch(this.rootUrl + '/api/' + parameter + '/list',
                {headers: this.httpHeaders});
            const response = await rawResponse.json();
            const params = {};
            params[parameter] = response;
            StorageUtil.save('parameters', params);
            this[parameter] = response;
            return response;
        } catch (e) {
            console.error('fetching parameter error', e);
            return false;
        }
    }

    public static async deleteAllSavedParametersAndFetchAgain() {
        StorageUtil.delete('parameters');
        delete this.warehouse;
        delete this.unit;
        delete this.materialItem;
        await this.getAllParameters()
        return {
            unit: this.unit,
            warehouse: this.warehouse,
            materialItem: this.materialItem
        }
    }
}
