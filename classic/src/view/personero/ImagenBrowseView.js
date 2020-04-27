/**
 * Created by LOPEZSOFT on 15/02/2016.
 */
var imageTpl = new Ext.XTemplate(
    '<p class="pm">Para votar <b>haga click sobre la foto</b> del candidato de su preferencia</p>',
    '<tpl for=".">',
        '<div class="thumb-wrap">',
            '<span>{estados}</span>',
            '<div class="thumb-{candidatura}">',
                '<img alt="{nombres}" src="{foto}"/>',
                '<div class="frigth"><p class="ptop">{numero}</p></div>',
            '</div>',
            '<span>{nombres}<br>{grado}-{grupo}</span>',
        '</div>',
    '</tpl>'
);

Ext.define('Admin.view.personero.ImagenBrowserView', {
    extend  : 'Ext.view.View',
    alias   : 'widget.ImagenBrowserView',

    uses    : 'Admin.store.personero.CandidatosStore',

    singleSelect    : false,
    overItemCls     : 'x-view-over',
    itemSelector    : 'div.thumb-wrap',
    tpl             : imageTpl,
    store           : 'CandidatosStore',
    liveDrag        : true,
    items           : {
        xtype   : 'customButton',
        text    : 'Ejemplo'
    },
    initComponent: function() {

        this.callParent(arguments);
    }
});