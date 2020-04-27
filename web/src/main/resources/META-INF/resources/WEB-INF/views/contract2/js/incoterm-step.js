var incotermStepTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermStepTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(incotermStepTab.listGrid.fields, incotermStepTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermStepTab, "api/incoterm-step/");
