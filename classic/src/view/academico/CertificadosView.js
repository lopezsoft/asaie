/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.academico.CertificadosView',{
    extend      : 'Admin.view.academico.ConstanciasView',
    alias       : 'widget.certificados',
    xtype       : 'certificados',
    itemId      : 'CertificadosView',
    initComponent: function () {
        var me  = Admin.getApplication();
        me.onStore('personero.CandidatosSearchStore');
        me.onStore('general.PeriodosStore');
        this.callParent(arguments);
        this.setTitle(AppLang.getSTitleViewStudyCertificates() + ' - ' + Global.getYear());
        this.down('#periodo').setHidden(false);
    }
});