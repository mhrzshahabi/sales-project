// isc.defineClass("IncotermDetail", isc.DynamicForm).addProperties({
//     align: "center",
//     canSubmit: true,
//     showErrorText: true,
//     showErrorStyle: true,
//     showInlineErrors: true,
//     aspect: null,
//     detailRecord: null,
//     fields: BaseFormItems.concat([
//         {
//             hidden: true,
//             required: true,
//             name: "incotermStepsId",
//         },
//         {
//             hidden: true,
//             required: true,
//             name: "incotermRulesId",
//         },
//         {
//             hidden: true,
//             required: true,
//             name: "incotermAspectId",
//         },
//         {
//             hidden: true,
//             name: "termId",
//         },
//         {
//             width: "100%",
//             height: "100%",
//             name: "incotermParties",
//             editorType: "IncotermParties",
//         }
//     ], true),
//     initWidget: function () {
//
//         this.fields.filter(q => q.name === "incotermParties").first().required = this.aspect.requiredParty;
//         this.Super("initWidget", arguments);
//         this.editRecord(this.detailRecord);
//     }
// });
