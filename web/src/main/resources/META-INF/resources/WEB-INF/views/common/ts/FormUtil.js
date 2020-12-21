//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var FormUtil = /** @class */ (function () {
        function FormUtil() {
            this.populateData = function (bodyWidget) {
                return [];
            };
            this.cancelCallBack = function () {
                return;
            };
            this.validate = function (data) {
                return true;
            };
            this.okCallBack = function (data) {
                return data;
            };
        }
        FormUtil.prototype.showForm = function (ownerWindow, title, canvas, width, height, showOkButton) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            if (showOkButton === void 0) { showOkButton = true; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.bodyWidget = new nicico.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(showOkButton), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FormUtil.prototype.init = function (ownerWindow, title, canvas, width, height, showOkButton) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            if (showOkButton === void 0) { showOkButton = true; }
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.bodyWidget = new nicico.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(showOkButton), width, height);
        };
        FormUtil.prototype.justShowForm = function () {
            if (this.owner.getObject() != null)
                this.owner.getObject().close();
            this.windowWidget.getObject().show();
        };
        FormUtil.prototype.getButtonLayout = function (showOkButton) {
            var This = this;
            // @ts-ignore
            var cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                },
            });
            var ok;
            if (showOkButton) {
                // @ts-ignore
                ok = isc.IButtonSave.create({
                    // @ts-ignore
                    click: function () {
                        var data = This.populateData(This.bodyWidget.getObject());
                        if (!This.validate(data))
                            return;
                        This.windowWidget.getObject().close();
                        if (This.owner.getObject() != null)
                            This.owner.getObject().show();
                        This.okCallBack(data);
                    },
                });
            }
            return isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        };
        FormUtil.prototype.createWindow = function (title, buttonLayout, width, height) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            var This = this;
            width = width == null ? "50%" : width;
            var items = [];
            if (This.bodyWidget.getObject().constructor === Array)
                // @ts-ignore
                items.addAll(This.bodyWidget.getObject());
            else
                items.add(This.bodyWidget.getObject());
            items.add(buttonLayout);
            This.actionWidget = new nicico.ObjectHider(buttonLayout);
            // @ts-ignore
            This.windowWidget = new nicico.ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, items, width, height), {
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                }
            }));
        };
        return FormUtil;
    }());
    nicico.FormUtil = FormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
