Ember.TEMPLATES.application=Ember.Handlebars.template(function(e,t,n,r,i){this.compilerInfo=[4,">= 1.0.0"],n=this.merge(n,Ember.Handlebars.helpers),i=i||{};var o,a,s,l,u="",c=n.helperMissing,d=this.escapeExpression;return i.buffer.push('<div class="container">\n  '),a={},s={},l={hash:{},contexts:[t],types:["ID"],hashContexts:s,hashTypes:a,data:i},i.buffer.push(d((o=n.render||t.render,o?o.call(t,"navbar",l):c.call(t,"render","navbar",l)))),i.buffer.push("\n  "),a={},s={},i.buffer.push(d(n._triageMustache.call(t,"outlet",{hash:{},contexts:[t],types:["ID"],hashContexts:s,hashTypes:a,data:i}))),i.buffer.push("\n</div>\n"),u});