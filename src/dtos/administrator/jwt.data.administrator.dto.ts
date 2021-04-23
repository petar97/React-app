export class JwtDataAdministratorDto {
    administratorId: number;
    username: string;
    exp: number;
    ip: string;
    ua: string;

    toPlainObject() {
        return {
            administratorId: this.administratorId,
            username: this.username,
            exp: this.exp,
            ip: this.ip,
            ua: this.ua
        }
    }
}