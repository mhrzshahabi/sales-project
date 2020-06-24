var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(contractTab.listGrid.fields, contractTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/g-contract/");
