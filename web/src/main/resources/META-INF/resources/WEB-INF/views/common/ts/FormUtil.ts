//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>

// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace evaluation {

    //------------------------------------------ Classes -------------------------------------------

    export class FormUtil {

        private owner: ObjectHider<isc.Window>;
        private widget: ObjectHider<isc.Canvas>;
        private bodyWidget: ObjectHider<isc.Canvas>;
        private windowWidget: ObjectHider<isc.Window>;

        public populateData: any = function (bodyWidget: isc.Canvas) {

            return [];
        };
        public cancelCallBack: any = function () {

            return;
        };
        public okCallBack: any = function (data: Array<any>) {

            return data;
        };

        showForm(ownerWindow: isc.Window, title: string, canvas: isc.Canvas): void {

            this.owner = new ObjectHider(ownerWindow);
            this.bodyWidget = new ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        public getButtonLayout(): isc.HLayout {

            let This = this;
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
            let ok = isc.IButtonSave.create({

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
        }

        public createWindow(title: string, buttonLayout: isc.HLayout): void {

            let This = this;
            let vLayout = isc.VLayout.create({

                width: "100%",
                members: [
                    This.bodyWidget.getObject(),
                    buttonLayout
                ]
            });
            This.windowWidget = new ObjectHider(isc.Window.create({

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
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
