#!/usr/java/jdk1.8.0_31/bin/jjs -fv

var RouteBuilder = Java.type("org.apache.camel.builder.RouteBuilder");
var myRouteBuilder = Java.extend(RouteBuilder);
var route=new myRouteBuilder(){
    configure: function() {
       var _super = Java.super(route);     
       _super.from("file:src/data?noop=true")
			.choice()
                		.when( _super.xpath("/book/author = 'Alessio Soldano'"))
                    			.log("WebServices")
                    			.to("file:target/messages/WS")
			        .when( _super.xpath("/book/author = 'Francesco Marchioni'"))
                    			.log("Wildfly")
                    			.to("file:target/messages/Wildfly")
                		.otherwise()
                    			.log("Other books")
                    			.to("file:target/messages/others");
        
    }
};


var Main = Java.type("org.apache.camel.main.Main")
var mainCamel = new Main();
mainCamel.enableHangupSupport();
mainCamel.addRouteBuilder(route);
mainCamel.run();

