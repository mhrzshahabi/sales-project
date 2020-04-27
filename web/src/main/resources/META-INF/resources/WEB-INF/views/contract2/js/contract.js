var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.dynamicForm.fields = BaseFormItems;
contractTab.dynamicForm.fields.addAll([]);
Object.assign(contractTab.listGrid.fields, contractTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/contract/");
contractTab.dynamicForm.main.windowWidth = 500;
