//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    interface Creator {

        width: number | string;
        height: number | string;

        title: string;
        accept: string;
        recordId: number;
        entityName: string;

        owner: isc.Window;
        window: isc.Window;
        actionLayout: isc.HLayout;
        // @ts-ignore
        fileUploadForm: isc.FileUploadForm;

        url: string;
        method: string;
        contentType: string;
    }

    class CreatorImpl implements Creator {

        height: number | string;
        width: number | string;

        title: string;
        accept: string;
        recordId: number;
        entityName: string;

        owner: isc.Window;
        window: isc.Window;
        actionLayout: isc.HLayout;
        // @ts-ignore
        fileUploadForm: isc.FileUploadForm;

        method: string = "POST";
        url: string = "api/file";
        contentType: string = "application/json; charset=utf-8";
    }

    export class FileUtil {

        static cancelCallBack: any = function () {

            return;
        };

        static okCallBack: any = function (formData: FormData) {

            return formData;
        };
        // @ts-ignore
        static populateData: any = function (creator: Creator) {

            let formData = new FormData();
            let fileData = creator.fileUploadForm.getValues();
            let files = [];
            let fileMetaData = [];
            for (let i = 0; i < fileData.length; i++) {
                let metaData = fileData[i];
                files.add(metaData.fileData);
                fileMetaData.add({
                    "id": metaData.id,
                    "fileKey": metaData.fileKey,
                    "recordId": metaData.recordId,
                    "entityName": metaData.entityName,
                    "fileStatus": metaData.fileStatus,
                    "accessLevel": metaData.accessLevel
                });
            }
            files.forEach(q => formData.append("files", q));
            formData.append("fileMetaData", JSON.stringify(fileMetaData));

            return formData;
        };
        // @ts-ignore
        static validate: any = function (creator: Creator) {

            return true;
        };
        // @ts-ignore
        static save: any = function (creator: Creator, formData: FormData) {

            let This = this;
            let request = new XMLHttpRequest();
            request.open(creator.method, creator.url);
            request.setRequestHeader("contentType", creator.contentType);
            // @ts-ignore
            request.setRequestHeader("Authorization", BaseRPCRequest.httpHeaders.Authorization);
            request.send(formData);
            request.onreadystatechange = function () {

                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status === 0)
                        isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
                    else if (request.status === 500)
                        isc.warn(JSON.parse(request.responseText).errors.map(q => q.message).join('<br>'), {title: "<spring:message code='dialog_WarnTitle'/>"});
                    else if (request.status === 200 || request.status === 201) {

                        isc.say("<spring:message code='global.form.request.successful'/>");

                        This.okCallBack(creator.fileUploadForm.getValues());

                        creator.window.close();
                        if (creator.owner != null)
                            creator.owner.show();
                    } else {
                        // @ts-ignore
                        request.httpResponseCode = request.status;
                        // @ts-ignore
                        request.httpResponseText = request.responseText;
                        // @ts-ignore
                        isc.RPCManager.handleError(request);
                    }
                }
            };
        };

        static createFileUploadForm(creator: Creator): void {

            // @ts-ignore
            creator.fileUploadForm = isc.FileUploadForm.create({
                width: "100%",
                accept: creator.accept,
                recordId: creator.recordId,
                entityName: creator.entityName,
                // @ts-ignore
                fileStatusValueMap: Enums.fileStatus,
                // @ts-ignore
                accessLevelValueMap: Enums.fileAccessLevel
            });
        }

        static createButtonLayout(creator: Creator): void {

            let This = this;
            // @ts-ignore
            let cancel = isc.IButtonCancel.create({

                click: function () {

                    creator.window.close();
                    if (creator.owner != null)
                        creator.owner.show();

                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            // @ts-ignore
            let ok = isc.IButtonSave.create({

                click: function () {

                    let data = This.populateData(creator);
                    if (!This.validate(creator)) return;
                    This.save(creator, data);
                },
                icon: "pieces/16/save.png",
                title: '<spring:message code="global.ok" />'
            });

            creator.actionLayout = isc.HLayout.create({

                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        }

        static createWindow(creator: Creator): void {

            let width = creator.width ? creator.width : "70%";
            let height = creator.height ? creator.height : "600";

            creator.fileUploadForm.setHeight(height);
            // @ts-ignore
            creator.window = isc.Window.nicico.getDefault(creator.title, [creator.fileUploadForm, creator.actionLayout], width, height);
        }

        static show(owner: isc.Window, title: string, recordId: number, accept: string, entityName: string, width: string = null, height: string = null) {

            let creator = new CreatorImpl();

            creator.title = title;
            creator.accept = accept;
            creator.recordId = recordId;
            creator.entityName = entityName;
            creator.owner = owner;
            creator.width = width;
            creator.height = height;

            if (owner != null)
                owner.close();

            this.createFileUploadForm(creator);
            this.createButtonLayout(creator);
            this.createWindow(creator);

            creator.window.show();
            return creator.window;
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
