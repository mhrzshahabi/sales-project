//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    class FormUtil {
        constructor() {
            this.populateData = function (bodyWidget) {
                return [];
            };
            this.cancelCallBack = function () {

            };
            this.validate = function (data) {
                return true;
            };
            this.okCallBack = function (data) {
                return data;
            };
        }

        showForm(ownerWindow, title, canvas, width = null, height = null) {
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.bodyWidget = new nicico.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        init(ownerWindow, title, canvas, width = null, height = null) {
            this.owner = new nicico.ObjectHider(ownerWindow);
            this.bodyWidget = new nicico.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(), width, height);
        }

        justShowForm() {
            if (this.owner.getObject() != null)
                this.owner.getObject().close();
            this.windowWidget.getObject().show();
        }

        getButtonLayout() {
            let This = this;
            // @ts-ignore
            let cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            // @ts-ignore
            let ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    let data = This.populateData(This.bodyWidget.getObject());
                    if (!This.validate(data))
                        return;
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.okCallBack(data);
                },
                icon: "pieces/16/save.png",
                title: '<spring:message code="global.ok" />'
            });
            return isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        }

        createWindow(title, buttonLayout, width = null, height = null) {
            let This = this;
            width = width == null ? "50%" : width;
            let items = [];
            if (This.bodyWidget.getObject().constructor === Array)
                // @ts-ignore
                items.addAll(This.bodyWidget.getObject());
            else
                items.add(This.bodyWidget.getObject());
            items.add(buttonLayout);
            // @ts-ignore
            This.windowWidget = new nicico.ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, items, width, height), {
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                }
            }));
        }
    }
    nicico.FormUtil = FormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
