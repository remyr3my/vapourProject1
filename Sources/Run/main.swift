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

drop.get("cat") { request in
    return Response(redirect: "https://www.google.co.in/search?q=cat&oq=cat+&aqs=chrome..69i57j69i60l2j69i65j69i60j69i61.843j0j7&sourceid=chrome&ie=UTF-8")
}



try drop.run()
