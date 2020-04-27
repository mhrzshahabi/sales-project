var contractTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTypeTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(contractTypeTab.listGrid.fields, contractTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractTypeTab, "api/contract-type/");
