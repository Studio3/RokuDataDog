function getErrorSample() as Object
    return {
        type: "error",
        date: 0,
        application: {
		    id: ""
    	},
        session: {
    		id: "",
    		type: "user"
	    },
        view: {
    		id: "",
    		url: "Roku",
    		name: "ROKU"
	    },
        _dd: {
            format_version: 2
        }
        error: {
            message: "",
            source: "source",
            is_crash: true,
            backtrace: invalid
        }
    }
end function
