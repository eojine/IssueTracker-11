const SOFT_DELETE = "SOFT_DELETE_QUERY";
const OPEN_CLOSED = "OPEN_CLOSED_QUERY";

class Controller {
  constructor(Model) {
    this.Model = Model;
  }


    get = async (req, res) => {
        try {
            const [result] = await this.Model.get();
            return result.length === 0
                ? res.status(200).send({ data: [] })
                : res.status(200).send({ status: 'OK', data: result });
        } catch (error) {
            res.status(500).send({ status: error.message });
        }
    };

  post = async (req, res) => {};
  put = async (req, res) => {};

    delete = async (req, res) => {
        const id =
            Number(req.params.id) ||
            req.body.ids ||
            (req.body.ids && [...req.body.ids]?.map(Number)) ||
            Number(req.body['ids[]']) ||
            (req.body['ids[]'] && [...req.body['ids[]']]?.map(Number));
        const ids = typeof id === 'object' ? [...id] : [id];

    try {
      ids.forEach((id) => {
        this.Model.delete(id);
      });
      return res.status(200).send({ status: "OK" });
    } catch (error) {
      res.status(500).send({ status: error.message });
    }
  };

    patch = async (req, res) => {
        const id =
            Number(req.params.id) ||
            req.body.ids ||
            (req.body.ids && [...req.body.ids]?.map(Number)) ||
            Number(req.body['ids[]']) ||
            (req.body['ids[]'] && [...req.body['ids[]']]?.map(Number));
        const ids = typeof id === 'object' ? [...id] : [id];

        try {
            const OPTION = req.originalUrl.includes('status') ? OPEN_CLOSED : SOFT_DELETE;
            ids.forEach((id) => {
                this.Model.patch(id, OPTION);
            });
            return res.status(200).send({ status: 'OK' });
        } catch (error) {
            res.status(500).send({ status: error.message });
        }
    };
}

export default Controller;
