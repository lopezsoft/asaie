/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.view.personero.GradosSedesAsignadasView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Grados asignadas a la mesa',
    alias   : 'widget.GradosSedesAsignadasView',
    controller  : 'personero',
    height  : 250,
    items   : [
        {
            xtype   : 'customform',
            items   : [
                {
                    xtype   : 'CbGrados'
                },
                {
                    xtype   : 'CbGrupo'
                }
            ]
        }
    ]
});