
import fs from 'fs';
import path from 'path';
import yaml from 'yaml';
import swaggerUi from 'swagger-ui-express';
import { Application, RequestHandler } from 'express';

interface SwaggerUi {
  serve: RequestHandler[];
  setup: (spec: object) => RequestHandler;
}

interface SwaggerModule {
  (app: Application): void;
}

const swaggerUiTyped: SwaggerUi = swaggerUi;

const swaggerModule: SwaggerModule = (app) => {
  try {
    const file: string = fs.readFileSync(path.join(__dirname, 'openapi.yml'), 'utf8');
    const spec: object = yaml.parse(file);

    app.use('/api-docs', swaggerUiTyped.serve, swaggerUiTyped.setup(spec));
    console.log('[INFO] Swagger UI available at /api-docs');
  } catch (err: any) {
    console.error('[ERROR] Failed to load Swagger spec:', err.message);
  }
};

export default swaggerModule;
