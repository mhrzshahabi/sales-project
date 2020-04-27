var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(incotermTab.listGrid.fields, incotermTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/incoterm/");
