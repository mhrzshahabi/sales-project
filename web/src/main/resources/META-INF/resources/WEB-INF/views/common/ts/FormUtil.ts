//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class FormUtil {

        private owner: ObjectHider<isc.Window>;
        private bodyWidget: ObjectHider<isc.Canvas>;
        private windowWidget: ObjectHider<isc.Window>;

        public populateData: any = function (bodyWidget: isc.Canvas) {

            return [];
        };
        public cancelCallBack: any = function () {

            return;
        };
        public validate: any = function (data: Array<any>) {

            return true;
        };
        public okCallBack: any = function (data: Array<any>) {

            return data;
        };

        showForm(ownerWindow: isc.Window, title: string, canvas: isc.Canvas, width: string = null, height: string = null): void {

            this.owner = new ObjectHider(ownerWindow);
            this.bodyWidget = new ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        init(ownerWindow: isc.Window, title: string, canvas: isc.Canvas, width: string = null, height: string = null): void {

            this.owner = new ObjectHider(ownerWindow);
            this.bodyWidget = new ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(), width, height);
        }
        justShowForm(): void {

            if (this.owner.getObject() != null)
                this.owner.getObject().close();
            this.windowWidget.getObject().show();
        }

        public getButtonLayout(): isc.HLayout {

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
                    if (!This.validate(data)) return;

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

        public createWindow(title: string, buttonLayout: isc.HLayout, width: string = null, height: string = null): void {

            let This = this;
            width = width == null ? "50%" : width;
            height = height == null ? "500" : height;
            // @ts-ignore
            This.windowWidget = new ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, [This.bodyWidget.getObject(), buttonLayout], width, height), {

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
