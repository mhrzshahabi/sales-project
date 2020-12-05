//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var CreatorImpl = /** @class */ (function () {
        function CreatorImpl() {
            this.method = "POST";
            this.url = "api/files/create";
            this.contentType = "application/json; charset=utf-8";
        }
        return CreatorImpl;
    }());
    var FileUtil = /** @class */ (function () {
        function FileUtil() {
        }
        FileUtil.createFileUploadForm = function (creator) {
            // @ts-ignore
            creator.fileUploadForm = isc.FileUploadForm.create({
                width: "100%",
                accept: creator.accept,
                recordId: creator.recordId,
                entityName: creator.entityName,
                permissions: creator.permissions,
                // @ts-ignore
                fileStatusValueMap: Enums.fileStatus,
                // @ts-ignore
                accessLevelValueMap: Enums.fileAccessLevel
            });
        };
        FileUtil.createButtonLayout = function (creator) {
            var This = this;
            // @ts-ignore
            var cancel = isc.IButtonCancel.create({
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
            var ok = isc.IButtonSave.create({
                click: function () {
                    var data = This.populateData(creator);
                    if (!This.validate(creator))
                        return;
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
        };
        FileUtil.createWindow = function (creator) {
            var width = creator.width ? creator.width : "70%";
            var height = creator.height ? creator.height : "600";
            creator.fileUploadForm.setHeight(height);
            // @ts-ignore
            creator.window = isc.Window.nicico.getDefault(creator.title, [creator.fileUploadForm, creator.actionLayout], width, height);
        };
        FileUtil.show = function (owner, title, recordId, accept, entityName, permissions, width, height) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            var creator = new CreatorImpl();
            creator.title = title;
            creator.accept = accept;
            creator.recordId = recordId;
            creator.entityName = entityName;
            creator.permissions = permissions;
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
        };
        FileUtil.cancelCallBack = function () {
            return;
        };
        FileUtil.okCallBack = function (formData) {
            return formData;
        };
        // @ts-ignore
        FileUtil.populateData = function (creator) {
            var formData = new FormData();
            var fileData = creator.fileUploadForm.getValues();
            debugger;
            var files = [];
            var fileMetaData = [];
            for (var i = 0; i < fileData.length; i++) {
                var metaData = fileData[i];
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
            files.forEach(function (q) { return formData.append("files", q); });
            formData.append("fileMetaData", JSON.stringify(fileMetaData));
            return formData;
        };
        // @ts-ignore
        FileUtil.validate = function (creator) {
            return true;
        };
        // @ts-ignore
        FileUtil.save = function (creator, formData) {
            var This = this;
            var request = new XMLHttpRequest();
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
                        isc.warn(JSON.parse(request.responseText).errors.map(function (q) { return q.message; }).join('<br>'), { title: "<spring:message code='dialog_WarnTitle'/>" });
                    else if (request.status === 200 || request.status === 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        This.okCallBack(creator.fileUploadForm.getValues());
                        creator.window.close();
                        if (creator.owner != null)
                            creator.owner.show();
                    }
                    else {
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
        return FileUtil;
    }());
    nicico.FileUtil = FileUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
