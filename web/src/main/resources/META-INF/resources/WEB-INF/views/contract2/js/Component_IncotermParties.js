isc.defineClass("IncotermParties", isc.Label).addProperties({

    width: "100%",
    autoFit: false,
    autoDraw: false,
    index: -1,
    dataSource: [],
    incotermPartyComponent: null,
    click: function (form, item) {

        if (this.incotermPartyComponent == null)
            return;

        if (this.dataSource == null || this.dataSource.length === 0 || this.dataSource.length === 1) {

            this.index = (this.index + 1) % this.incotermPartyComponent.dataSource.length;
            let party = this.incotermPartyComponent.getParty(this.index);
            if (party == null)
                return;

            this.setBackgroundColor(party.bgColor);
            this.dataSource = [{portion: 100, incotermPartyId: party.id}];

            return;
        }

        this.doubleClick(form, item);
    },
    doubleClick: function (form, item) {

        if (this.incotermPartyComponent == null)
            return;

        let This = this;
        let currentData = {

            termId: form.getValue("termId"),
            incotermParties: This.dataSource
        };
        let callback = function (data) {

            form.setValue("termId", data.termId);
            This.dataSource = data.incotermParties;
            if (This.dataSource == null)
                This.dataSource = [];
            if (This.dataSource.length === 1) {

                for (let i = 0; i < This.incotermPartyComponent.dataSource.length; i++)
                    if (This.incotermPartyComponent.dataSource[i].id === This.dataSource[0].incotermPartyId)
                        This.index = i;
                let party = This.incotermPartyComponent.getParty(This.index);
                if (party == null)
                    return;

                This.setBackgroundColor(party.bgColor);
            } else
                this.setBackgroundColor("");
        }
        this.incotermPartyComponent.showPartyForm(currentData, callback);
    },
    initWidget: function () {

        this.Super("initWidget", arguments);
        if (this.incotermPartyComponent == null)
            return;
        if (this.dataSource == null)
            this.dataSource = [];

        if (this.dataSource.length === 1) {

            for (let i = 0; i < this.incotermPartyComponent.dataSource.length; i++)
                if (this.incotermPartyComponent.dataSource[i].id === this.dataSource[0].incotermPartyId)
                    this.index = i;
            let party = this.incotermPartyComponent.getParty(this.index);
            if (party == null)
                return;

            this.setBackgroundColor(party.bgColor);
        }
    },
    getValue: function () {
        return this.dataSource;
    }
});
