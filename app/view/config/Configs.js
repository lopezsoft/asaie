Ext.define('Admin.view.config.Configs', {
    singleton: true,
    alternateClassName: 'Global',
    config: {
        dbConfig: [],
        dbResult: '',
        period: '',
        year: 0,
        nomUser: '',
        indicatorsRecord: [], // Registro indicadores de desempeños
        recordAchievements: [], // Registro logros academicos
        dirGroup: false, // Si el estado es TRUE es director de grupo
        dataDirGroup: [], // Data del director de grupo
        dataTeacher: [], // Datos del docente
        obsType: 0, // Tipo de observador
        language: 'Es', // Idioma del sistema
        avatarMan: "/assets/img/avatars/man.png",
        avatarWomen: "/assets/img/avatars/woman.png",
        avatarUnknoun: "/assets/img/avatars/unknown.png",
        configReport: [],
        userData: [],
        socket: null,
        // hostSocket: 'https://ns547829.ip-66-70-178.net:3001',
        // urlBase: "https://schools.asaie.co/",
        // urlLocation: "https://schools.asaie.co/",
        hostSocket	: 'http://localhost:8081',
        urlBase 	: "http://asaie.test/",
        urlLocation : "http://asaie.test/",
        idSchool: 0,
        Userid: 0,
        userType: 0,
        dbName: 'asaie',
        competences: [],
        scale: [],
        columnsNotes: [],
        data: []
    },
    constructor: function(config) {
        this.initConfig(this.config, config);
    },

    isActive: function() {
        membership = this.getData().membership;
        return (membership.state == 1) ? true : false;
    },
    getCfg: function() {
        var
            data = this.getData();
        return {
            year: this.getYear(),
            UserId: data.user_id,
            userType: data.user_type,
            userParent: data.user_parent,
            db: data.db_name
        };
    },

    /**
     * Función para comparar objetos
     * @function compareObjects
     * @param obj1
     * @param obj2
     * @returns {boolean}
     */

    compareObjects: function(obj1, obj2) {
        return JSON.stringify(obj1) === JSON.stringify(obj2);
    },
    /**
     * Función que devuelve el socked
     * @function getSocket
     */
    getSocket: function() {
        var
            me = this;
        me.socket = io.connect(me.getHostSocket(), { 'forceNew': true });
        me.socket.on('connect_error', function(error) {
            console.log(error);
            Admin.getApplication().showResult('No hay conexión con el servidor de sockets, contante al administrador del sistema.', 'error');
        });
        return me.socket;
    },

    /** Función que devuelve el estado de la conexión del socket
     * @function getConnectionSocket
     * @returns {boolean} Estado de la conexión
     */

    getConnectionSocket: function() {
        var
            conn = this.getSocket();
        return conn.connected;
    },

    // Funcion que convierte en minuscula el primer carater de un String.
    getFirstLowerCase: function(s) {
        var xs = Ext.util.Format;
        return xs.substr(s, 0, 1).toLowerCase() + xs.substr(s, 1, s.length - 1);
    },
    /**
     * función generadora de colores aleatoreos
     */
    getRandomColor: function() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    },
    sha1: function() {
        // function 'f' [§4.1.1]
        var f = function(s, x, y, z) {
            switch (s) {
                case 0:
                    return (x & y) ^ (~x & z); // Ch()
                case 1:
                    return x ^ y ^ z; // Parity()
                case 2:
                    return (x & y) ^ (x & z) ^ (y & z); // Maj()
                case 3:
                    return x ^ y ^ z; // Parity()
            }
        };
        // rotate left (circular left shift) value x by n positions [§3.2.5]
        var ROTL = function(x, n) {
            return (x << n) | (x >>> (32 - n));
        };

        return {
            hash: function(msg) {
                // constants [§4.2.1]
                var K = [0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6];


                // PREPROCESSING

                msg += String.fromCharCode(0x80); // add trailing '1' bit to string [§5.1.1]

                // convert string msg into 512-bit/16-integer blocks arrays of ints [§5.2.1]
                var l = Math.ceil(msg.length / 4) + 2; // long enough to contain msg plus 2-word length
                var N = Math.ceil(l / 16); // in N 16-int blocks
                var M = new Array(N);
                for (var i = 0; i < N; i++) {
                    M[i] = new Array(16);
                    for (var j = 0; j < 16; j++) { // encode 4 chars per integer, big-endian encoding
                        M[i][j] = (msg.charCodeAt(i * 64 + j * 4) << 24) | (msg.charCodeAt(i * 64 + j * 4 + 1) << 16) |
                            (msg.charCodeAt(i * 64 + j * 4 + 2) << 8) | (msg.charCodeAt(i * 64 + j * 4 + 3));
                    }
                }
                // add length (in bits) into final pair of 32-bit integers (big-endian) [5.1.1]
                // note: most significant word would be ((len-1)*8 >>> 32, but since JS converts
                // bitwise-op args to 32 bits, we need to simulate this by arithmetic operators
                M[N - 1][14] = ((msg.length - 1) * 8) / Math.pow(2, 32);
                M[N - 1][14] = Math.floor(M[N - 1][14]);
                M[N - 1][15] = ((msg.length - 1) * 8) & 0xffffffff;

                // set initial hash value [§5.3.1]
                var H0 = 0x67452301;
                var H1 = 0xefcdab89;
                var H2 = 0x98badcfe;
                var H3 = 0x10325476;
                var H4 = 0xc3d2e1f0;

                // HASH COMPUTATION [§6.1.2]

                var W = new Array(80);
                var a, b, c, d, e;

                for (var i = 0; i < N; i++) {

                    // 1 - prepare message schedule 'W'
                    for (var t = 0; t < 16; t++) W[t] = M[i][t];
                    for (var t = 16; t < 80; t++) W[t] = ROTL(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1);

                    // 2 - initialise five working variables a, b, c, d, e with previous hash value
                    a = H0;
                    b = H1;
                    c = H2;
                    d = H3;
                    e = H4;

                    // 3 - main loop
                    for (var t = 0; t < 80; t++) {
                        var s = Math.floor(t / 20); // seq for blocks of 'f' functions and 'K' constants
                        var T = (ROTL(a, 5) + f(s, b, c, d) + e + K[s] + W[t]) & 0xffffffff;
                        e = d;
                        d = c;
                        c = ROTL(b, 30);
                        b = a;
                        a = T;
                    }

                    // 4 - compute the new intermediate hash value
                    H0 = (H0 + a) & 0xffffffff; // note 'addition modulo 2^32'
                    H1 = (H1 + b) & 0xffffffff;
                    H2 = (H2 + c) & 0xffffffff;
                    H3 = (H3 + d) & 0xffffffff;
                    H4 = (H4 + e) & 0xffffffff;
                }

                return H0.toHexStr() + H1.toHexStr() + H2.toHexStr() + H3.toHexStr() + H4.toHexStr();
            }
        }
    }
});

Ext.Sha1 = function() {
    // function 'f' [§4.1.1]
    var f = function(s, x, y, z) {
        switch (s) {
            case 0:
                return (x & y) ^ (~x & z); // Ch()
            case 1:
                return x ^ y ^ z; // Parity()
            case 2:
                return (x & y) ^ (x & z) ^ (y & z); // Maj()
            case 3:
                return x ^ y ^ z; // Parity()
        }
    };
    // rotate left (circular left shift) value x by n positions [§3.2.5]
    var ROTL = function(x, n) {
        return (x << n) | (x >>> (32 - n));
    };
    return {
        hash: function(msg) {
            // constants [§4.2.1]
            var K = [0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6];


            // PREPROCESSING

            msg += String.fromCharCode(0x80); // add trailing '1' bit to string [§5.1.1]

            // convert string msg into 512-bit/16-integer blocks arrays of ints [§5.2.1]
            var l = Math.ceil(msg.length / 4) + 2; // long enough to contain msg plus 2-word length
            var N = Math.ceil(l / 16); // in N 16-int blocks
            var M = new Array(N);
            for (var i = 0; i < N; i++) {
                M[i] = new Array(16);
                for (var j = 0; j < 16; j++) { // encode 4 chars per integer, big-endian encoding
                    M[i][j] = (msg.charCodeAt(i * 64 + j * 4) << 24) | (msg.charCodeAt(i * 64 + j * 4 + 1) << 16) |
                        (msg.charCodeAt(i * 64 + j * 4 + 2) << 8) | (msg.charCodeAt(i * 64 + j * 4 + 3));
                }
            }
            // add length (in bits) into final pair of 32-bit integers (big-endian) [5.1.1]
            // note: most significant word would be ((len-1)*8 >>> 32, but since JS converts
            // bitwise-op args to 32 bits, we need to simulate this by arithmetic operators
            M[N - 1][14] = ((msg.length - 1) * 8) / Math.pow(2, 32);
            M[N - 1][14] = Math.floor(M[N - 1][14]);
            M[N - 1][15] = ((msg.length - 1) * 8) & 0xffffffff;

            // set initial hash value [§5.3.1]
            var H0 = 0x67452301;
            var H1 = 0xefcdab89;
            var H2 = 0x98badcfe;
            var H3 = 0x10325476;
            var H4 = 0xc3d2e1f0;

            // HASH COMPUTATION [§6.1.2]

            var W = new Array(80);
            var a, b, c, d, e;
            for (var i = 0; i < N; i++) {

                // 1 - prepare message schedule 'W'
                for (var t = 0; t < 16; t++) W[t] = M[i][t];
                for (var t = 16; t < 80; t++) W[t] = ROTL(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1);

                // 2 - initialise five working variables a, b, c, d, e with previous hash value
                a = H0;
                b = H1;
                c = H2;
                d = H3;
                e = H4;

                // 3 - main loop
                for (var t = 0; t < 80; t++) {
                    var s = Math.floor(t / 20); // seq for blocks of 'f' functions and 'K' constants
                    var T = (ROTL(a, 5) + f(s, b, c, d) + e + K[s] + W[t]) & 0xffffffff;
                    e = d;
                    d = c;
                    c = ROTL(b, 30);
                    b = a;
                    a = T;
                }

                // 4 - compute the new intermediate hash value
                H0 = (H0 + a) & 0xffffffff; // note 'addition modulo 2^32'
                H1 = (H1 + b) & 0xffffffff;
                H2 = (H2 + c) & 0xffffffff;
                H3 = (H3 + d) & 0xffffffff;
                H4 = (H4 + e) & 0xffffffff;
            }

            return H0.toHexStr() + H1.toHexStr() + H2.toHexStr() + H3.toHexStr() + H4.toHexStr();
        }
    }
}();

/**
 * @class Number
 */
Ext.applyIf(Number.prototype, {
    /**
     * extend Number class with a tailored hex-string method (note toString(16) is implementation-dependant, and in IE returns signed numbers when used on full words)
     * @return {String} The number in Hexidecimal format.
     */
    toHexStr: function() {
        var s = '',
            v;
        for (var i = 7; i >= 0; i--) {
            v = (this >>> (i * 4)) & 0xf;
            s += v.toString(16);
        }
        return s;
    }
});
