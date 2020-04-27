/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidaturaView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Candidaturas',
    controller  : 'personero',
    alias   : 'widget.CandidaturaView',
    height  : 250,
    items   : [
        {
            xtype   : 'customform',
            defaultType : 'TextField',
            items   : [
                {
                    name        : 'candidatura',
                    fieldLabel  : 'Nombre de la candidatura'
                },
                {
                    xtype		: 'radioGroup',
                    columns		: 1,
                    vertical	: true,
                    fieldLabel	: 'Estado',
                    items		: [
                        {
                            boxLabel	: 'Activo',
                            name		: 'estado',
                            inputValue	: 'true',
                            checked		: true
                        },
                        {
                            boxLabel	: 'Inactivo',
                            name		: 'estado',
                            inputValue	: 'false'
                        }
                    ]
                }
            ]
        }
    ]
});