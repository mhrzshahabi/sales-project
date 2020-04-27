var incotermAspectTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermAspectTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(incotermAspectTab.listGrid.fields, incotermAspectTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermAspectTab, "api/incoterm-aspect/");
