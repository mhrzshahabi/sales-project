//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
///<reference path="BasicFormUtil.ts"/>
///<reference path="FormUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var ReportFormUtil = /** @class */ (function () {
        function ReportFormUtil() {
        }
        ReportFormUtil.createRestDataSource = function (creator) {
            // @ts-ignore
            creator.restDataSource.main = isc.RestDataSource.nicico.getDefault(creator.variable.url + "spec-list", creator.method.transformRequest);
        };
        ReportFormUtil.createFilterBuilder = function (creator) {
            // @ts-ignore
            creator.filterBuilder.main = isc.FilterBuilder.nicico.getDefault(creator.restDataSource.main);
        };
        ReportFormUtil.createVLayout = function (creator) {
            // @ts-ignore
            creator.vLayout.main = isc.VLayout.create({
                width: "100%",
                height: "100%",
                overflow: "auto",
                // @ts-ignore
                members: [
                    isc.LayoutSpacer.create({ height: "20" }),
                    // @ts-ignore
                    creator.filterBuilder.main,
                    isc.LayoutSpacer.create({ height: "50" }),
                    isc.IButton.create({
                        width: 110,
                        height: 40,
                        margin: 5,
                        title: "<spring:message code='global.search'/>",
                        icon: "icon/search.png",
                        // @ts-ignore
                        click: function () {
                        }
                    }),
                ]
            });
        };
        ReportFormUtil.createWindow = function (creator, title) {
            // @ts-ignore
            creator.window.main = isc.Window.create({
                width: "40%",
                height: "30%",
                title: title,
                autoCenter: true,
                isModal: true,
                showModalMask: true,
                align: "center",
                autoSize: true,
                autoDraw: true,
                canDragResize: true,
                dismissOnEscape: true,
                // @ts-ignore
                members: [creator.vLayout.main]
            });
        };
        ReportFormUtil.showForm = function (restControllerUrl, title) {
            var creator = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
            // @ts-ignore
            creator.variable.url += restControllerUrl.replaceAll(new RegExp("^/|/$"), '') + '/';
            this.createRestDataSource(creator);
            this.createFilterBuilder(creator);
            this.createVLayout(creator);
            this.createWindow(creator, title);
            // @ts-ignore
            creator.window.main.show();
            // @ts-ignore
            return creator.window.main;
        };
        return ReportFormUtil;
    }());
    nicico.ReportFormUtil = ReportFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
