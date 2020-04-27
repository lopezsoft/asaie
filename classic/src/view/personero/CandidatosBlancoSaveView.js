/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidatosBlancoSaveView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.CandidatosBlancoSaveView',
    controller  : 'personero',
    title       : 'Candidatos',
    height      : 200,
    items       : [
        {
            xtype   : 'customform',
            items   : [
                {
                    xtype       : 'CbCandidaturas'
                }
            ]
        }
    ]
});