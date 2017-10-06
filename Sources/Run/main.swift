import App

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands, 
/// if no command is given, it will default to "serve"
let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()

drop.get("hi"){request in
    return "hellojsdbc"
}


drop.get("hi/greetings") { req in

    let name = req.data["name"]?.string ?? ", what's your name? :D"
    return "Hello \(name)"

    //            var json = JSON()
    //            try json.set("hello", "world")
    //            return json
}


drop.get("/name",":name") { request in
    if let name = request.parameters["name"]?.string {
        return "Hello \(name)!"
    }
    return "Error retrieving parameters."
}


drop.post("userVerification"){ request in
       let  name = request.data["name"]?.string
      let  pass = request.data["pass"]?.string
    
    if name == pass{
    var json = JSON()
        try json.set("Username"," \(name!)")
        try json.set("password"," \(pass!)")
          try json.set("Message","Success")
    return json
    }else{
        var json = JSON()
    try json.set("Message","Unsuccesfull")
            return json
    }
}

drop.get("cat") { request in
    return Response(redirect: "https://www.google.co.in/search?biw=1895&bih=847&tbm=isch&sa=1&q=black+cat&oq=black+cat&gs_l=psy-ab.3..0i67k1l2j0j0i67k1.7338.10150.0.10913.6.6.0.0.0.0.174.651.4j2.6.0....0...1.1.64.psy-ab..0.6.650...0i7i30k1j0i13k1j0i10k1.0.UU9Hnzc9vb0")
}



try drop.run()
