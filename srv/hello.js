module.exports = class say {
    hello(req) {
        return `Hello ${req.data.str}!` 
    }

    sum(req) { 
        //const { a, b } = req.data;
        const sum = req.data.a + req.data.b;
        //const sum = a + b;
        return sum 
    }

    combined(req) { 
        //const { a, b } = req.data;
        const sum = req.data.a + req.data.b;
        //const sum = a + b;
        return `Hello ${req.data.str}!. ${req.data.a} + ${req.data.b} = ${sum}`
    }
}