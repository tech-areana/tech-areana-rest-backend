type LogFn = (...args: unknown[]) => void;

export interface Logger {
  info: LogFn;
  error: LogFn;
}

const logger: Logger = {
  info: (...args) => console.log('[INFO]', ...args),
  error: (...args) => console.error('[ERROR]', ...args),
};

export default logger;
