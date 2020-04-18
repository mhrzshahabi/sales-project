//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var FormUtil = /** @class */ (function () {
        function FormUtil() {
            this.populateData = function (bodyWidget) {
                return [];
            };
            this.cancelCallBack = function () {
                return;
            };
            this.okCallBack = function (data) {
                return data;
            };
        }
        FormUtil.prototype.showForm = function (ownerWindow, title, canvas) {
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.bodyWidget = new evaluation.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FormUtil.prototype.getButtonLayout = function () {
            var This = this;
            var cancel = isc.IButtonCancel.create({
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
            var ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.okCallBack(This.populateData(This.bodyWidget.getObject()));
                },
                icon: "pieces/16/approve.png",
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
        };
        FormUtil.prototype.createWindow = function (title, buttonLayout) {
            var This = this;
            var vLayout = isc.VLayout.create({
                width: "100%",
                members: [
                    This.bodyWidget.getObject(),
                    buttonLayout
                ]
            });
            This.windowWidget = new evaluation.ObjectHider(isc.Window.create({
                title: title,
                width: "50%",
                align: "center",
                items: [vLayout],
                isModal: true,
                autoSize: true,
                autoDraw: false,
                autoCenter: true,
                showModalMask: true,
                dismissOnEscape: false,
                dismissOnOutsideClick: false,
                // @ts-ignore
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                }
            }));
        };
        return FormUtil;
    }());
    evaluation.FormUtil = FormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//