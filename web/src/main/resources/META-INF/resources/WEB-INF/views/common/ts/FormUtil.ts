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
        private windowWidget: ObjectHider<isc.Window>;
        private actionWidget: ObjectHider<isc.Canvas>;
        private bodyWidget: ObjectHider<isc.Canvas | Array<isc.Canvas>>;

        public populateData: any = function (bodyWidget: isc.Canvas | Array<isc.Canvas>) {

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

        showForm(ownerWindow: isc.Window, title: string, canvas: isc.Canvas | Array<isc.Canvas>, width: string = null, height: string = null, showOkButton: boolean = true): void {

            this.owner = new ObjectHider(ownerWindow);
            this.bodyWidget = new ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(showOkButton), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        }

        init(ownerWindow: isc.Window, title: string, canvas: isc.Canvas | Array<isc.Canvas>, width: string = null, height: string = null, showOkButton: boolean = true): void {

            this.owner = new ObjectHider(ownerWindow);
            this.bodyWidget = new ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout(showOkButton), width, height);
        }

        justShowForm(): void {

            if (this.owner.getObject() != null)
                this.owner.getObject().close();
            this.windowWidget.getObject().show();
        }

        public getButtonLayout(showOkButton): isc.HLayout {

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
            });
            let ok;
            if (showOkButton) {
                // @ts-ignore
                ok = isc.IButtonSave.create({

                    // @ts-ignore
                    click: function () {

                        let data = This.populateData(This.bodyWidget.getObject());
                        if (!This.validate(data)) return;

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
        }

        public createWindow(title: string, buttonLayout: isc.HLayout, width: string = null, height: string = null): void {

            let This = this;
            width = width == null ? "50%" : width;
            let items = [];
            if (This.bodyWidget.getObject().constructor === Array)
            // @ts-ignore
                items.addAll(This.bodyWidget.getObject());
            else
                items.add(This.bodyWidget.getObject());
            items.add(buttonLayout);
            This.actionWidget = new ObjectHider(buttonLayout);
            // @ts-ignore
            This.windowWidget = new ObjectHider(Object.assign(isc.Window.nicico.getDefault(title, items, width, height), {

                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                }
            }));
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
