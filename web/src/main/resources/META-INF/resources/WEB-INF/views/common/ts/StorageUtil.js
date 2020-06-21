/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2019.full.d.ts"/>
/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2017.object.d.ts"/>
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts"/>
// <%@ page contentType="text/html;charset=UTF-8" %>
class StorageUtil {
    static save(name, option) {
        //option = typeof (option) === 'string' ? JSON.parse(option) : option;
        name = name.toString();
        const storage_name = this._prefix;
        let allOptions_str = localStorage.getItem(storage_name);
        if (allOptions_str === null || allOptions_str === undefined)
            allOptions_str = "{}";
        const allOptions = JSON.parse(allOptions_str);
        if (Object.keys(allOptions).indexOf(name) < 0 ||
            typeof (allOptions[name]) !== typeof (option) ||
            typeof (allOptions[name]) !== 'object')
            allOptions[name] = option;
        try {
            Object.assign(allOptions[name], allOptions[name], option);
        }
        catch (e) {
            allOptions[name] = option;
        }
        localStorage.setItem(storage_name, JSON.stringify(allOptions));
    }
    ;
    static get(name) {
        name = name.toString();
        const storage_name = this._prefix;
        let allOptions = localStorage.getItem(storage_name);
        if (allOptions === null || allOptions === undefined)
            return null;
        const all = JSON.parse(allOptions);
        let result = all;
        Object.values(arguments).forEach(k => result = result[k]);
        return result;
    }
    ;
}
StorageUtil._prefix = 'sales';
class SalesBaseParameters {
    static async getParameter(parameter, updateTable = false) {
        if (updateTable) {
            const dialog = isc.Dialog.create({
                title: "<spring:message code='global.please.wait'/>",
                message: "<spring:message code='global.this.may.takes.a.while'/>"
            });
            await fetch(this.rootUrl + '/api/' + parameter + '/update-all', { headers: this.httpHeaders });
            await this.fetchAndSave(parameter);
            dialog.close();
        }
        else if (!this[parameter]) {
            const parameters = StorageUtil.get('parameters');
            if (!parameters || !parameters[parameter]) {
                await this.fetchAndSave(parameter);
            }
            else
                this[parameter] = parameters[parameter];
        }
        return await this[parameter];
    }

    static async getUnitParameter(updateTable = false) {
        return await this.getParameter('unit', updateTable);
    }

    static async getWarehouseParameter(updateTable = false) {
        return await this.getParameter('warehouse', updateTable);
    }

    static async getMaterialItemParameter(updateTable = false) {
        return await this.getParameter('materialItem', updateTable);
    }

    static async getAllParameters(updateTable = false) {
        await Promise.all([
            this.getUnitParameter(updateTable),
            this.getWarehouseParameter(updateTable),
            this.getMaterialItemParameter(updateTable)
        ]);
        return {
            'materialItem': this.materialItem,
            'unit': this.unit,
            'warehouse': this.warehouse
        };
    }
    static async fetchAndSave(parameter) {
        try {
            const rawResponse = await fetch(this.rootUrl + '/api/' + parameter + '/list', {headers: this.httpHeaders});
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
}
SalesBaseParameters.rootUrl = document.URL.split("?")[0].slice(-1) === "/"
    ? document.URL.split("?")[0].slice(0, -1)
    : document.URL.split("?")[0];
SalesBaseParameters.httpHeaders = { "Authorization": "Bearer <%= accessToken %>" };
