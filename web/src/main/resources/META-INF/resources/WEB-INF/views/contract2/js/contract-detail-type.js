var contractDetailTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(contractDetailTypeTab.listGrid.fields, contractDetailTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractDetailTypeTab, "api/contract-detail-type/");
