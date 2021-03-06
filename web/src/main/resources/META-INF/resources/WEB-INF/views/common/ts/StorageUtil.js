var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2019.full.d.ts"/>
/// <reference path="/usr/lib/node_modules/typescript/lib/lib.es2017.object.d.ts"/>
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts"/>
// <%@ page contentType="text/html;charset=UTF-8" %>
var StorageUtil = /** @class */ (function () {
    function StorageUtil() {
    }
    StorageUtil.save = function (name, option) {
        //option = typeof (option) === 'string' ? JSON.parse(option) : option;
        name = name.toString();
        var storage_name = this._prefix;
        var allOptions_str = localStorage.getItem(storage_name);
        if (allOptions_str === null || allOptions_str === undefined)
            allOptions_str = "{}";
        var allOptions = JSON.parse(allOptions_str);
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
    };
    ;
    StorageUtil.get = function () {
        var args = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            args[_i] = arguments[_i];
        }
        var storage_name = this._prefix;
        var allOptions = localStorage.getItem(storage_name);
        if (allOptions === null || allOptions === undefined)
            return null;
        var all = JSON.parse(allOptions);
        var result = all;
        args.forEach(function (k) { return result = result[k]; });
        return result;
    };
    ;
    StorageUtil.delete = function () {
        var args = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            args[_i] = arguments[_i];
        }
        var storage_name = this._prefix;
        var allOptions = localStorage.getItem(storage_name);
        if (allOptions === null || allOptions === undefined)
            return true;
        var all = JSON.parse(allOptions);
        try {
            var forEval = 'delete all["' + args.join('"]["') + '"]';
            eval(forEval);
            localStorage.setItem(storage_name, JSON.stringify(all));
            return true;
        }
        catch (e) {
            console.error('storageUtil delete error', e);
            return false;
        }
    };
    StorageUtil._prefix = 'sales';
    return StorageUtil;
}());
var SalesBaseParameters = /** @class */ (function () {
    function SalesBaseParameters() {
    }
    SalesBaseParameters.getParameter = function (parameter, updateTable) {
        if (updateTable === void 0) { updateTable = false; }
        return __awaiter(this, void 0, void 0, function () {
            var dialog, parameters;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!updateTable) return [3 /*break*/, 3];
                        dialog = isc.Dialog.create({
                            title: "<spring:message code='global.please.wait'/>",
                            message: "<spring:message code='global.this.may.takes.a.while'/>"
                        });
                        return [4 /*yield*/, fetch(this.rootUrl + '/api/' + parameter + '/update-all', { headers: this.httpHeaders })];
                    case 1:
                        _a.sent();
                        return [4 /*yield*/, this.fetchAndSave(parameter)];
                    case 2:
                        _a.sent();
                        dialog.close();
                        return [3 /*break*/, 6];
                    case 3:
                        if (!!this[parameter]) return [3 /*break*/, 6];
                        parameters = StorageUtil.get('parameters');
                        if (!(!parameters || !parameters[parameter])) return [3 /*break*/, 5];
                        return [4 /*yield*/, this.fetchAndSave(parameter)];
                    case 4:
                        _a.sent();
                        return [3 /*break*/, 6];
                    case 5:
                        this[parameter] = parameters[parameter];
                        _a.label = 6;
                    case 6: return [4 /*yield*/, this[parameter]];
                    case 7: return [2 /*return*/, _a.sent()];
                }
            });
        });
    };
    SalesBaseParameters.getUnitParameter = function (updateTable) {
        if (updateTable === void 0) { updateTable = false; }
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.getParameter('unit', updateTable)];
                    case 1: return [2 /*return*/, _a.sent()];
                }
            });
        });
    };
    SalesBaseParameters.getSavedWarehouseParameter = function () {
        return this.warehouse;
    };
    SalesBaseParameters.getSavedUnitParameter = function () {
        return this.unit;
    };
    SalesBaseParameters.getSavedMaterialItemParameter = function () {
        return this.materialItem;
    };
    SalesBaseParameters.getAllSavedParameter = function () {
        return {
            'materialItem': this.materialItem,
            'unit': this.unit,
            'warehouse': this.warehouse
        };
    };
    SalesBaseParameters.getWarehouseParameter = function (updateTable) {
        if (updateTable === void 0) { updateTable = false; }
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.getParameter('warehouse', updateTable)];
                    case 1: return [2 /*return*/, _a.sent()];
                }
            });
        });
    };
    SalesBaseParameters.getMaterialItemParameter = function (updateTable) {
        if (updateTable === void 0) { updateTable = false; }
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.getParameter('materialItem', updateTable)];
                    case 1: return [2 /*return*/, _a.sent()];
                }
            });
        });
    };
    SalesBaseParameters.getAllParameters = function (updateTable) {
        if (updateTable === void 0) { updateTable = false; }
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, Promise.all([
                            this.getUnitParameter(updateTable),
                            this.getWarehouseParameter(updateTable),
                            this.getMaterialItemParameter(updateTable)
                        ])];
                    case 1:
                        _a.sent();
                        return [2 /*return*/, {
                                'materialItem': this.materialItem,
                                'unit': this.unit,
                                'warehouse': this.warehouse
                            }];
                }
            });
        });
    };
    SalesBaseParameters.fetchAndSave = function (parameter) {
        return __awaiter(this, void 0, void 0, function () {
            var rawResponse, response, params, e_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        _a.trys.push([0, 3, , 4]);
                        return [4 /*yield*/, fetch(this.rootUrl + '/api/' + parameter + '/list', { headers: this.httpHeaders })];
                    case 1:
                        rawResponse = _a.sent();
                        return [4 /*yield*/, rawResponse.json()];
                    case 2:
                        response = _a.sent();
                        params = {};
                        params[parameter] = response;
                        StorageUtil.save('parameters', params);
                        this[parameter] = response;
                        return [2 /*return*/, response];
                    case 3:
                        e_1 = _a.sent();
                        console.error('fetching parameter error', e_1);
                        return [2 /*return*/, false];
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    SalesBaseParameters.deleteAllSavedParametersAndFetchAgain = function () {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        StorageUtil.delete('parameters');
                        delete this.warehouse;
                        delete this.unit;
                        delete this.materialItem;
                        return [4 /*yield*/, this.getAllParameters()];
                    case 1:
                        _a.sent();
                        return [2 /*return*/, {
                                unit: this.unit,
                                warehouse: this.warehouse,
                                materialItem: this.materialItem
                            }];
                }
            });
        });
    };
    SalesBaseParameters.rootUrl = document.URL.split("?")[0].slice(-1) === "/"
        ? document.URL.split("?")[0].slice(0, -1)
        : document.URL.split("?")[0];
    SalesBaseParameters.httpHeaders = { "Authorization": "Bearer <%= accessToken %>" };
    return SalesBaseParameters;
}());
