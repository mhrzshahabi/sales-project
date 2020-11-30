//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var ActionType;
    (function (ActionType) {
        ActionType[ActionType["REFRESH"] = 0] = "REFRESH";
        ActionType[ActionType["NEW"] = 1] = "NEW";
        ActionType[ActionType["EDIT"] = 2] = "EDIT";
        ActionType[ActionType["DELETE"] = 3] = "DELETE";
        ActionType[ActionType["ACTIVATE"] = 4] = "ACTIVATE";
        ActionType[ActionType["DEACTIVATE"] = 5] = "DEACTIVATE";
        ActionType[ActionType["FINALIZE"] = 6] = "FINALIZE";
        ActionType[ActionType["DISAPPROVE"] = 7] = "DISAPPROVE";
    })(ActionType = nicico.ActionType || (nicico.ActionType = {}));
    var BasicFormUtil = /** @class */ (function () {
        function BasicFormUtil() {
        }
        BasicFormUtil.createToolStrip = function (creator) {
            // @ts-ignore
            creator.toolStrip.main = isc.ToolStrip.create({
                width: "100%",
                members: [
                    // <c:if test = "${c_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonAdd.create({
                        // @ts-ignore
                        actionType: ActionType.NEW,
                        icon: "[SKIN]/actions/add.png",
                        title: "<spring:message code='global.form.new'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.newForm('<spring:message code="global.form.new"/>', creator.listGrid.main, creator.dynamicForm.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonEdit.create({
                        // @ts-ignore
                        actionType: ActionType.EDIT,
                        icon: "[SKIN]/actions/edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    // @ts-ignore
                    isc.ToolStripButtonRemove.create({
                        // @ts-ignore
                        actionType: ActionType.DELETE,
                        icon: "[SKIN]/actions/remove.png",
                        title: "<spring:message code='global.form.remove'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${a_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        // @ts-ignore
                        actionType: ActionType.ACTIVATE,
                        visibility: "hidden",
                        icon: "[SKIN]/actions/configure.png",
                        title: "<spring:message code='global.active'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.activate(creator.listGrid.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${i_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        // @ts-ignore
                        actionType: ActionType.DEACTIVATE,
                        visibility: "hidden",
                        icon: "[SKIN]/actions/exclamation.png",
                        title: "<spring:message code='global.inactive'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.deactivate(creator.listGrid.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${f_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        // @ts-ignore
                        actionType: ActionType.FINALIZE,
                        visibility: "hidden",
                        icon: "[SKIN]/actions/accept.png",
                        title: "<spring:message code='global.form.accept'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.finalize(creator.listGrid.main);
                        }
                    }),
                    // </c:if>
                    // <c:if test = "${o_entity}">
                    // @ts-ignore
                    isc.ToolStripButton.create({
                        // @ts-ignore
                        actionType: ActionType.DISAPPROVE,
                        visibility: "hidden",
                        icon: "[SKIN]/actions/undo.png",
                        title: "<spring:message code='global.form.disapprove'/>",
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            creator.method.disapprove(creator.listGrid.main);
                        }
                    }),
                    // </c:if>
                    isc.ToolStrip.create({
                        width: "100%",
                        border: '0px',
                        name: "refresh",
                        align: nicico.CommonUtil.getAlignByLang(),
                        members: [
                            // @ts-ignore
                            isc.ToolStripButtonRefresh.create({
                                // @ts-ignore
                                actionType: ActionType.REFRESH,
                                title: "<spring:message code='global.form.refresh'/>",
                                click: function () {
                                    // @ts-ignore
                                    creator.method.refresh(creator.listGrid.main);
                                }
                            })
                        ]
                    })
                ]
            });
        };
        BasicFormUtil.createRestDataSource = function (creator) {
            // @ts-ignore
            creator.restDataSource.main = isc.RestDataSource.nicico.getDefault(creator.variable.url + "spec-list", creator.listGrid.fields, creator.method.transformRequest);
        };
        BasicFormUtil.createListGrid = function (creator) {
            // @ts-ignore
            creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, creator.listGrid.criteria);
        };
        BasicFormUtil.createTabSet = function (creator) {
            // @ts-ignore
            creator.tab.main = isc.TabSet.create({
                width: "100%",
                height: "100%",
                tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
                showTabScroller: true,
                border: "1px solid lightblue",
                edgeMarginSize: 3,
                tabBarThickness: 80,
                tabs: [
                    {
                        title: "<spring:message code='global.tab'/>",
                        pane: creator.listGrid.main
                    },
                ]
            });
        };
        BasicFormUtil.createListGridMenu = function (creator) {
            // @ts-ignore
            creator.menu.main = isc.Menu.create({
                width: 150,
                items: [
                    {
                        // @ts-ignore
                        actionType: ActionType.REFRESH,
                        icon: "pieces/16/refresh.png",
                        title: '<spring:message code="global.form.refresh"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.refresh(creator.listGrid.main);
                        }
                    },
                    // <c:if test = "${c_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.NEW,
                        icon: "pieces/16/icon_add.png",
                        title: '<spring:message code="global.form.new"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.newForm('<spring:message code="global.form.new"/>', creator.listGrid.main, creator.dynamicForm.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${u_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.EDIT,
                        icon: "pieces/16/icon_edit.png",
                        title: "<spring:message code='global.form.edit'/>",
                        click: function () {
                            // @ts-ignore
                            creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${d_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.DELETE,
                        icon: "pieces/16/icon_delete.png",
                        title: '<spring:message code="global.form.remove"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.delete(creator.listGrid.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${a_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.ACTIVATE,
                        icon: "pieces/16/configure.png",
                        title: '<spring:message code="global.active"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.activate(creator.listGrid.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${i_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.DEACTIVATE,
                        icon: "pieces/16/exclamation.png",
                        title: '<spring:message code="global.inactive"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.deactivate(creator.listGrid.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${f_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.FINALIZE,
                        icon: "pieces/16/accept.png",
                        title: '<spring:message code="global.form.accept"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.finalize(creator.listGrid.main);
                        }
                    },
                    // </c:if>
                    // <c:if test = "${o_entity}">
                    {
                        // @ts-ignore
                        actionType: ActionType.DISAPPROVE,
                        icon: "pieces/16/undo.png",
                        title: '<spring:message code="global.form.disapprove"/>',
                        click: function () {
                            // @ts-ignore
                            creator.method.disapprove(creator.listGrid.main);
                        }
                    }
                    // </c:if>
                ]
            });
            // @ts-ignore
            isc.Canvas.nicico.changeProperties(creator.listGrid.main, "contextMenu", creator.menu.main);
        };
        BasicFormUtil.createDynamicForm = function (creator) {
            // @ts-ignore
            creator.dynamicForm.main = isc.DynamicForm.nicico.getDefault(creator.dynamicForm.fields);
            // @ts-ignore
            creator.dynamicForm.main.hide();
        };
        BasicFormUtil.createVLayout = function (creator) {
            // @ts-ignore
            creator.vLayout.main = isc.VLayout.create({
                width: "100%",
                // @ts-ignore
                members: [creator.toolStrip.main, creator.listGrid.main]
            });
        };
        BasicFormUtil.createVLayoutWithTabSet = function (creator) {
            // @ts-ignore
            creator.vLayout.main = isc.VLayout.create({
                width: "100%",
                // @ts-ignore
                members: [creator.toolStrip.main, creator.tab.main]
            });
        };
        BasicFormUtil.removeExtraGridMenuActions = function (creator) {
            // @ts-ignore
            var actionTypes = creator.toolStrip.main.members.filter(function (q) { return q.visibility === "hidden"; }).map(function (q) { return q.actionType; });
            this.removeGridMenuByActions(creator, actionTypes);
        };
        BasicFormUtil.removeGridMenuByActions = function (creator, actionTypes) {
            if (!actionTypes || !actionTypes.length)
                return;
            // @ts-ignore
            var menuItems = creator.menu.main.data.filter(function (q) { return actionTypes.contains(q.actionType); });
            // @ts-ignore
            menuItems.forEach(function (menuItem) { return creator.menu.main.data.remove(menuItem); });
            // @ts-ignore
            creator.menu.main.initWidget();
        };
        BasicFormUtil.removeExtraActions = function (creator, actionTypes) {
            if (!actionTypes || !actionTypes.length)
                return;
            this.hideToolStripActions(creator, actionTypes);
            this.removeGridMenuByActions(creator, actionTypes);
        };
        BasicFormUtil.showAllToolStripActions = function (creator) {
            // @ts-ignore
            creator.toolStrip.main.members.forEach(function (toolStripItem) { return toolStripItem.setVisibility("visible"); });
        };
        BasicFormUtil.showToolStripActions = function (creator, actionTypes) {
            if (!actionTypes || !actionTypes.length)
                return;
            // @ts-ignore
            var toolStripItems = creator.toolStrip.main.members.filter(function (q) { return actionTypes.contains(q.actionType); });
            toolStripItems.forEach(function (toolStripItem) { return toolStripItem.setVisibility("visible"); });
        };
        BasicFormUtil.hideToolStripActions = function (creator, actionTypes) {
            if (!actionTypes || !actionTypes.length)
                return;
            // @ts-ignore
            var toolStripItems = creator.toolStrip.main.members.filter(function (q) { return actionTypes.contains(q.actionType); });
            toolStripItems.forEach(function (toolStripItem) { return toolStripItem.setVisibility("hidden"); });
        };
        BasicFormUtil.getDefaultBasicForm = function (creator, restControllerUrl, createWindowHook) {
            if (createWindowHook === void 0) { createWindowHook = null; }
            // @ts-ignore
            creator.variable.url += restControllerUrl.replaceAll(new RegExp("^/|/$"), '') + '/';
            this.createDynamicForm(creator);
            this.createRestDataSource(creator);
            this.createListGrid(creator);
            // <c:if test = "${u_entity}">
            // @ts-ignore
            creator.listGrid.main.recordDoubleClick = function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                // @ts-ignore
                creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main);
            };
            // </c:if>
            this.createListGridMenu(creator);
            this.createToolStrip(creator);
            if (createWindowHook && createWindowHook instanceof Function)
                createWindowHook(creator);
            this.createVLayout(creator);
            // @ts-ignore
            return creator.vLayout.main;
        };
        BasicFormUtil.getDefaultBasicFormWithTabSet = function (creator, restControllerUrl, createWindowHook) {
            if (createWindowHook === void 0) { createWindowHook = null; }
            // @ts-ignore
            creator.variable.url += restControllerUrl.replaceAll(new RegExp("^/|/$"), '') + '/';
            this.createDynamicForm(creator);
            this.createRestDataSource(creator);
            this.createListGrid(creator);
            this.createListGridMenu(creator);
            this.createToolStrip(creator);
            this.createTabSet(creator);
            // <c:if test = "${u_entity}">
            // @ts-ignore
            creator.listGrid.main.recordDoubleClick = function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                // @ts-ignore
                creator.method.editForm('<spring:message code="global.form.edit"/>', creator.listGrid.main, creator.dynamicForm.main);
            };
            // </c:if>
            if (createWindowHook && createWindowHook instanceof Function)
                createWindowHook(creator);
            this.createVLayoutWithTabSet(creator);
            // @ts-ignore
            return creator.vLayout.main;
        };
        return BasicFormUtil;
    }());
    nicico.BasicFormUtil = BasicFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
