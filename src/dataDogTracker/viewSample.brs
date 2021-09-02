' Copyright 2021 EPIX Entertainment LLC
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.

function getViewSample() as Object
    return {
        type: "view",
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
    		name: "ROKU",
            time_spent: 0,
            error: {
                count: 1
            }
        },
        _dd: {
            format_version: 2,
            document_version: 1
        }
    }
end function
